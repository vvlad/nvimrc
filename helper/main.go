package main

import (
	"crypto/md5"
	"fmt"
	"github.com/neovim/go-client/nvim"
	"os"
	"os/exec"
	"path/filepath"
)

func main() {
	if len(os.Args) != 2 {
		err := exec.Command("neovide").Run()
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		os.Exit(0)
	}

	path, err := filepath.Abs(os.Args[1])
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	address := lookupServerAddress(path)
	v, err := nvim.Dial(address)
	if err != nil {
		err := exec.Command("neovide", os.Args[1], "--", "--listen", address).Run()
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		os.Exit(0)
	}
	var result interface{}
	v.ExecLua(fmt.Sprintf("return require(\"helpers.file\").edit(\"%s\", true)", path), result)

}

func lookupServerAddress(path string) string {
	if os.Getenv("NVIM") != "" {
		return os.Getenv("NVIM")
	}
	for {
		address := socketAddress(path)
		if _, err := os.Stat(address); err == nil {
			return address
		}

		if _, err := os.Stat(filepath.Join(path, ".git")); err == nil {
			return address
		}

		path = filepath.Dir(path)
		if path == "/" {
			break
		}
	}

	fileInfo, err := os.Stat(path)
	if err == nil && fileInfo.IsDir() {
		return socketAddress(path)
	}

	return socketAddress(filepath.Dir(path))
}

func socketAddress(path string) string {
	return filepath.Join(os.Getenv("XDG_RUNTIME_DIR"), fmt.Sprintf("neovide-%s.sock", md5sum(path)))
}

func md5sum(path string) string {
	h := md5.New()
	h.Write([]byte(path))
	return fmt.Sprintf("%x", h.Sum(nil))
}
