{
  pkgs,
  clib,
  ...
}: {
  xdg.configFile."leftwm/themes/current/ws".source = (clib.writers pkgs).writeGo "ws" ''
    package main

    import (
    	"bufio"
    	"encoding/json"
    	"fmt"
    	"os"
    	"os/exec"
    	"strings"
    )

    type LeftTags struct {
    	Name    string
    	Index   float64
    	Mine    bool
    	Visible bool
    	Focused bool
    	Urgent  bool
    	Busy    bool
    }

    type LeftWorkspace struct {
    	Id     float64
    	Output string
    	H      float64
    	W      float64
    	X      float64
    	Y      float64
    	Layout string
    	Index  float64
    	Tags   []LeftTags
    }

    type LeftStatus struct {
    	Window_title string
    	Workspaces   []LeftWorkspace
    }

    func main() {
    	statusJson, err := getCurrStatus()
    	if err != nil {
    		fmt.Println(err)
    		return
    	}

    	var status LeftStatus
    	err = json.Unmarshal([]byte(statusJson), &status)
    	if err != nil {
    		fmt.Println(err)
    		return
    	}

    	widx, tidx := getIdxOf(status, os.Args[1] != "up")
      if widx == -1 {
          return
      }

    	err = exec.Command(
    		"leftwm-command",
    		fmt.Sprintf("SendWorkspaceToTag %d %d", int(status.Workspaces[widx].Index), int(status.Workspaces[widx].Tags[tidx].Index)),
    	).Run()
    	if err != nil {
    		fmt.Println(err)
    	}
    }

    func getIdxOf(status LeftStatus, next bool) (widx, tidx int) {
    	var (
    		findNextBusy = false
    		prevBusyIdx  = 0
    	)

    	for i, w := range status.Workspaces {
    		for j, t := range w.Tags {
    			// next
    			if t.Mine && next {
    				findNextBusy = true
    				continue
    			}
    			if findNextBusy && t.Busy {
    				widx = i
    				tidx = j
    				return
    			}

    			// prev
    			if t.Mine && !next {
    				widx = i
    				tidx = prevBusyIdx
    				return
    			}
    			if !next && t.Busy {
    				prevBusyIdx = j
    				continue
    			}
    		}
    	}

    	return -1, -1
    }

    func getCurrStatus() (string, error) {
    	cmd := exec.Command("leftwm-state")

    	pipe, err := cmd.StdoutPipe()
    	if err != nil {
    		return "", err
    	}

    	if err := cmd.Start(); err != nil {
    		return "", err
    	}

    	out := ""

    	scanner := bufio.NewScanner(pipe)
    	if scanner.Scan() {
    		out = strings.TrimSpace(scanner.Text())
    	}

    	cmd.Process.Kill()
    	cmd.Wait()

    	return out, nil
    }
  '';
}
