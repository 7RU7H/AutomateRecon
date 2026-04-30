package main

import (
	"flag"
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"
)

func testWebservers(ipAddress string) (testHTTP, testHTTPS bool, err error) {

}

// Use first test connectivity with curl and then to download the http and https root webpages
func downloadWebRootSource(ipAddress, protocol string) error {
	var cmdArgs string
	builder := strings.Builder{}

	builder.WriteString(protocol)
	builder.WriteString("://")
	builder.WriteString(ipAddress)
	builder.WriteString(" -o ")
	builder.WriteString(protocol)
	builder.WriteString("-www-root.html")
	cmdArgs = builder.String()
	curlWebRootHTTP := exec.Command("curl", cmdArgs)
	if err := curlWebRootHTTP.Start(); err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		fmt.Fprintf(os.Stdout, "Unable to execute `%s %s`\n", "curl", cmdArgs)
		return err
	}
	if err := curlWebRootHTTP.Wait(); err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		fmt.Fprintf(os.Stdout, "Unable to complete execution of `%s %s`\n", "curl", cmdArgs)
		return err
	}

	time.Sleep(1 * time.Second)
	fmt.Fprintf(os.Stdout, "Completed attempts to curl %s://%s", protocol, ipAddress)

	return nil
}

func main() {
	var ipAddress string
	// var workingDirectory string

	flag.StringVar(&ipAddress, "i", "127.0.0.1", "Provide a IP address to target enumeration tasks")
	//flag.StringVar(&workingDirectory, "d", "$PWD", "Provide a working directory to save output")
	flag.Parse()

	if len(os.Args) <= 1 {
		err := fmt.Errorf("Not enough arguments provided: %v", os.Args)
		fmt.Fprintln(os.Stdout, "Error: Unable to parse CLI arguments: Not enough correct flags and arguments provided: ", os.Args)
		fmt.Fprintln(os.Stderr, "Error: Unable to parse CLI arguments: ", err)
		os.Exit(-1)
	}

	// Ping host to get TTL data to detirmine OS type
	pingHostThrice := exec.Command("ping", "-c 3", ipAddress)
	_, err := pingHostThrice.StdoutPipe()
	if err != nil {
		panic(err)
	}
	if err := pingHostThrice.Start(); err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		fmt.Fprintf(os.Stdout, "Unable to execute `%s %s`\n", "ping -c 3 ", ipAddress)
	}
	if err := pingHostThrice.Wait(); err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		fmt.Fprintf(os.Stdout, "Unable to complete execution of `%s %s`\n", "ping -c 3 ", ipAddress)
	}

	time.Sleep(1 * time.Second)
	fmt.Fprintf(os.Stdout, "Completed attempts to ping host")

}
