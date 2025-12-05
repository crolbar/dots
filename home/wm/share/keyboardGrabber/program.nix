{
  clib,
  pkgs,
  keebName,
  ...
}: ((clib.writers pkgs).writeGo "keyboardGrabber" ''
  package main

  /*
   #include <linux/input.h>
  */
  import "C"

  import (
  	"os"
  	"path/filepath"
  	"strings"
  	"syscall"
  	"unsafe"
  )

  const NAME = "${keebName}"

  func main() {
  	event := getEventByDevName(NAME);

  	fd, err := syscall.Open("/dev/input/"+event, syscall.O_RDONLY, 0)
  	if err != nil {
  		panic(err)
  	}

  	err = Grab(uintptr(fd))
  	if err != nil {
  		panic(err)
  	}

  	select {}
  }

  func getEventByDevName(name string) string {
  	basePath := "/sys/class/input"

  	entries, err := os.ReadDir(basePath)
  	if err != nil {
  		panic(err)
  	}

  	for _, entry := range entries {
  		if !strings.HasPrefix(entry.Name(), "event") {
  			continue
  		}

  		eventPath := filepath.Join(basePath, entry.Name())
  		namePath := filepath.Join(eventPath, "device", "name")

  		data, err := os.ReadFile(namePath)
  		if err != nil {
  			continue
  		}

  		readName := strings.TrimSpace(string(data))
  		if readName == name {
  			return entry.Name()
  		}
  	}

  	return ""
  }

  func Grab(fd uintptr) error {
  	grab := int(1)
  	if err := ioctl(fd, uintptr(C.EVIOCGRAB), unsafe.Pointer(&grab)); err != 0 {
  		return err
  	}

  	return nil
  }

  func ioctl(fd uintptr, name uintptr, data unsafe.Pointer) syscall.Errno {
  	_, _, err := syscall.RawSyscall(syscall.SYS_IOCTL, fd, name, uintptr(data))
  	return err
  }
'')
