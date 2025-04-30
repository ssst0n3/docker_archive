package main

import (
	"os"
	"time"
)

func init() {
	if len(os.Args) > 1 && os.Args[1] == "init" {
		var flag bool
		for {
			if flag {
				break
			}
			time.Sleep(time.Second)
		}
	}
}