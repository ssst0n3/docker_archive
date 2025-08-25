package main

import (
	"bufio"
	"context"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"io"
	"log"
	"math/rand"
	"net"
	"strings"
	"time"

	"github.com/docker/docker/api/types/container"
	"github.com/docker/docker/api/types/image"
	"github.com/docker/docker/client"
)

const (
	listenPort        = ":8080"
	connectionTimeout = 5 * time.Minute
)

func handleConnection(conn net.Conn) {
	defer conn.Close()
	log.Printf("Client connected: %s", conn.RemoteAddr())

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	if err := conn.SetDeadline(time.Now().Add(connectionTimeout)); err != nil {
		log.Printf("Failed to set deadline for %s: %v", conn.RemoteAddr(), err)
		return
	}
	fmt.Fprintf(conn, "Welcome! The connection will be terminated after %v.\n", connectionTimeout)

	if err := performProofOfWork(conn); err != nil {
		log.Printf("PoW failed for client %s: %v", conn.RemoteAddr(), err)
		fmt.Fprintln(conn, "Proof of Work failed. Closing connection.")
		return
	}
	fmt.Fprintln(conn, "Proof of Work successful!")

	if err := runDockerInteraction(ctx, conn); err != nil {
		log.Printf("Docker interaction failed for client %s: %v", conn.RemoteAddr(), err)
		fmt.Fprintf(conn, "Error: %v\n", err)
		return
	}

	log.Printf("Session for client %s ended successfully.", conn.RemoteAddr())
}

func performProofOfWork(conn net.Conn) error {
	// Seed the random number generator for each connection to ensure unique challenges.
	rand.Seed(time.Now().UnixNano())

	// Define a charset that matches Python's string.ascii_letters+string.digits.
	const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

	proofBytes := make([]byte, 20)
	for i := range proofBytes {
		proofBytes[i] = charset[rand.Intn(len(charset))]
	}
	proofStr := string(proofBytes)

	hash := sha256.Sum256([]byte(proofStr))
	digest := hex.EncodeToString(hash[:])

	// The first 4 bytes are the secret prefix (xxxx), and the rest is the public suffix.
	secretPrefix := proofStr[:4]
	publicSuffix := proofStr[4:]

	challengeMsg := fmt.Sprintf("sha256(xxxx+%s) == %s\n", publicSuffix, digest)
	if _, err := fmt.Fprint(conn, challengeMsg); err != nil {
		return fmt.Errorf("failed to send challenge: %w", err)
	}
	if _, err := fmt.Fprintln(conn, "Give me xxxx:"); err != nil {
		return fmt.Errorf("failed to send prompt: %w", err)
	}

	reader := bufio.NewReader(conn)
	userInput, err := reader.ReadString('\n')
	if err != nil {
		if err == io.EOF {
			return fmt.Errorf("client disconnected before providing proof")
		}
		return fmt.Errorf("failed to read proof from client: %w", err)
	}
	// Clean up the user input, removing trailing newline and whitespace.
	userInput = strings.TrimSpace(userInput)

	if len(userInput) != 4 || userInput != secretPrefix {
		log.Printf("PoW failed for %s. Expected: '%s', Got: '%s'", conn.RemoteAddr(), secretPrefix, userInput)
		return fmt.Errorf("invalid proof of work")
	}

	log.Printf("PoW successful for %s.", conn.RemoteAddr())
	return nil
}

func runDockerInteraction(ctx context.Context, conn net.Conn) error {
	fmt.Fprint(conn, "Please enter the Docker image to run (e.g., busybox:latest): ")
	reader := bufio.NewReader(conn)
	imageName, err := reader.ReadString('\n')
	if err != nil {
		return fmt.Errorf("failed to read image name: %w", err)
	}
	imageName = strings.TrimSpace(imageName)
	if imageName == "" {
		return fmt.Errorf("image name cannot be empty")
	}

	log.Printf("Client %s requested to run image: %s", conn.RemoteAddr(), imageName)

	cli, err := client.NewClientWithOpts(client.FromEnv, client.WithAPIVersionNegotiation())
	if err != nil {
		return fmt.Errorf("failed to create Docker client: %w", err)
	}
	defer cli.Close()

	fmt.Fprintf(conn, "Pulling image %s... This may take a moment.\n", imageName)
	pullReader, err := cli.ImagePull(ctx, imageName, image.PullOptions{})
	if err != nil {
		return fmt.Errorf("failed to pull image %s: %w", imageName, err)
	}
	io.Copy(conn, pullReader)
	pullReader.Close()
	fmt.Fprintln(conn, "Image pull complete.")

	fmt.Fprintln(conn, "Creating container with GPU support...")

	hostConfig := &container.HostConfig{
		Runtime: "nvidia",
		Resources: container.Resources{
			DeviceRequests: []container.DeviceRequest{
				{
					Driver:       "nvidia",
					Count:        -1,
					Capabilities: [][]string{{"gpu"}},
				},
			},
		},
	}

	resp, err := cli.ContainerCreate(ctx, &container.Config{
		Image:        imageName,
		Cmd:          []string{"/bin/sh"},
		Tty:          true,
		AttachStdin:  true,
		AttachStdout: true,
		AttachStderr: true,
		OpenStdin:    true,
	}, hostConfig, nil, nil, "")

	if err != nil {
		return fmt.Errorf("failed to create container: %w", err)
	}

	defer func() {
		log.Printf("Cleaning up container %s for client %s", resp.ID[:12], conn.RemoteAddr())

		cleanupCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()

		if err := cli.ContainerStop(cleanupCtx, resp.ID, container.StopOptions{}); err != nil {
			log.Printf("Failed to stop container %s: %v", resp.ID, err)
		}

		if err := cli.ContainerRemove(cleanupCtx, resp.ID, container.RemoveOptions{Force: true}); err != nil {
			log.Printf("Failed to remove container %s: %v", resp.ID, err)
		}
		log.Printf("Container %s cleaned up.", resp.ID[:12])
	}()

	attachResp, err := cli.ContainerAttach(ctx, resp.ID, container.AttachOptions{
		Stream: true,
		Stdin:  true,
		Stdout: true,
		Stderr: true,
	})
	if err != nil {
		return fmt.Errorf("failed to attach to container: %w", err)
	}
	defer attachResp.Close()

	if err := cli.ContainerStart(ctx, resp.ID, container.StartOptions{}); err != nil {
		return fmt.Errorf("failed to start container: %w", err)
	}

	fmt.Fprintln(conn, "--- Connected to container terminal (with GPU support) ---")
	fmt.Fprintln(conn, "You can now type commands. The session will end after 5 minutes or when you exit the shell.")
	fmt.Fprintln(conn, "Try running 'ls -lah /dev/nvidia*' to verify GPU access.")

	done := make(chan error, 1)

	go func() {
		_, err := io.Copy(conn, attachResp.Reader)
		done <- err
	}()

	go func() {
		_, err := io.Copy(attachResp.Conn, conn)
		if err != nil {
			log.Printf("Client->container stream ended for %s: %v", conn.RemoteAddr(), err)
		}
		attachResp.CloseWrite()
	}()

	if err := <-done; err != nil && err != io.EOF {
		log.Printf("Stream from container to client was interrupted: %v", err)
	}

	log.Printf("Session for client %s is ending, container will be cleaned up.", conn.RemoteAddr())
	return nil
}

func main() {
	listener, err := net.Listen("tcp", listenPort)
	if err != nil {
		log.Fatalf("Failed to start TCP server: %v", err)
	}
	defer listener.Close()
	log.Printf("TCP server started, listening on %s", listenPort)

	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Printf("Failed to accept connection: %v", err)
			continue
		}
		go handleConnection(conn)
	}
}
