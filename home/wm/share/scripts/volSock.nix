{
  browser,
  musicPlayer,
  ...
}: ''
  package main

  import (
  	"bufio"
  	"errors"
  	"fmt"
  	"net"
  	"os"
  	"os/exec"
  	"strings"
  )

  const (
  	socketPath  = "/tmp/volSock"
  	musicName   = "${musicPlayer}"
  	browserName = "${browser}"
  )

  var (
  	musicId    = ""
  	browserIds = make([]string, 0)
  )

  func updateIndexes() {
  	cmd := exec.Command("pactl", "list", "sink-inputs")
  	out, err := cmd.Output()
  	if err != nil {
  		fmt.Println("err:", err)
  	}

  	var (
  		inputs = strings.Split(string(out), "\n\n")
  	)

  	browserIds = make([]string, 0)

  	for _, i := range inputs {
  		var (
  			props = strings.Split(i, "\n")
  			id, _ = strings.CutPrefix(props[0], "Sink Input #")
  		)

  		for _, p := range props {
  			p = strings.Trim(p, "\t")

  			switch p {
  			case fmt.Sprintf("application.name = \"%s\"", musicName):
  				musicId = id
  			case fmt.Sprintf("application.name = \"%s\"", browserName):
  				browserIds = append(browserIds, id)
  			}

  		}
  	}
  }

  func upVol(id string) error {
  	if id == "" {
  		return errors.New("id empty")
  	}

  	return exec.Command("pactl", "set-sink-input-volume", id, "+4%").Run()
  }

  func downVol(id string) error {
  	if id == "" {
  		return errors.New("id empty")
  	}

  	return exec.Command("pactl", "set-sink-input-volume", id, "-4%").Run()
  }

  func retryMusic(c func(string) error) {
  	fmt.Println("retrying music")

  	updateIndexes()
  	c(musicId)
  }

  func retryBrowser(c func(string) error) {
  	fmt.Println("retrying browser")

  	updateIndexes()
  	for _, id := range browserIds {
  		c(id)
  	}
  }

  func handleMessage(ch chan string) {
  	var err error
  	for msg := range ch {
  		fmt.Println("recived", msg)

  		if msg[0] == 'b' && len(browserIds) == 0 {
  			updateIndexes()
  		}

  		switch msg {
  		case "mu":
  			err = upVol(musicId)
  			if err != nil {
  				retryMusic(upVol)
  			}
  		case "md":
  			err = downVol(musicId)
  			if err != nil {
  				retryMusic(downVol)
  			}
  		case "bu":
  			for _, id := range browserIds {
  				err = upVol(id)
  				if err != nil {
  					retryBrowser(upVol)
  					break
  				}
  			}
  		case "bd":
  			for _, id := range browserIds {
  				err = downVol(id)
  				if err != nil {
  					retryBrowser(downVol)
  					break
  				}
  			}
  		}
  	}
  }

  func handleConnection(conn net.Conn, messages chan string) {
  	defer conn.Close()

  	scanner := bufio.NewScanner(conn)
  	for scanner.Scan() {
  		messages <- scanner.Text()
  	}
  }

  func main() {
  	os.Remove(socketPath)

  	listener, err := net.Listen("unix", socketPath)
  	if err != nil {
  		fmt.Println("creation error: ", err)
  		return
  	}
  	defer listener.Close()
  	fmt.Println("listening on", socketPath)

  	ch := make(chan string, 100)

  	go handleMessage(ch)

  	for {
  		conn, err := listener.Accept()
  		if err != nil {
  			fmt.Println("Accept error:", err)
  			continue
  		}

  		go handleConnection(conn, ch)
  	}
  }
''
