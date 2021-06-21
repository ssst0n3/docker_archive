# docker archive

## rebuild dockerd binary

```
git clone https://github.com/moby/moby.git
git checkout v19.03.0
sed -i "s@build %s@build %s, remove osusergo tag@g" cmd/dockerd/docker.go
sed -i "s/osusergo//g" hack/make.sh
make BIND_DIR=. shell
```

build binary, yes you will the glibc warning
```
root@da1acb618da1:/go/src/github.com/docker/docker# hack/make.sh binary

Removing bundles/

---> Making bundle: binary (in bundles/binary)
Building: bundles/binary-daemon/dockerd-dev
GOOS="" GOARCH="" GOARM=""
# github.com/docker/docker/cmd/dockerd
/tmp/go-link-611217491/000008.o: In function `mygetgrouplist':
/usr/local/go/src/os/user/getgrouplist_unix.go:16: warning: Using 'getgrouplist' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/tmp/go-link-611217491/000007.o: In function `mygetgrgid_r':
/usr/local/go/src/os/user/cgo_lookup_unix.go:38: warning: Using 'getgrgid_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/tmp/go-link-611217491/000007.o: In function `mygetgrnam_r':
/usr/local/go/src/os/user/cgo_lookup_unix.go:43: warning: Using 'getgrnam_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/tmp/go-link-611217491/000007.o: In function `mygetpwnam_r':
/usr/local/go/src/os/user/cgo_lookup_unix.go:33: warning: Using 'getpwnam_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/tmp/go-link-611217491/000007.o: In function `mygetpwuid_r':
/usr/local/go/src/os/user/cgo_lookup_unix.go:28: warning: Using 'getpwuid_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
Created binary: bundles/binary-daemon/dockerd-dev
Copying nested executables into bundles/binary-daemon
```

then we have get the rebuild binary at bundles/binary-daemon/dockerd-dev