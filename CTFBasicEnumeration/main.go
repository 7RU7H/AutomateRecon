package main

import (
	"context"
	"flag"
	"fmt"
	"net/http"
	"os"
	"os/exec"
	"os/signal"
	"strings"
	"syscall"
	"time"
)

// Wrapper that handles cancel() for CTRL+C termination
func handleTermination(cancel context.CancelFunc) {
	fmt.Printf("Terminating application...\n")
	cancel()
	os.Exit(0)
}

// Ping host to get TTL data to detirmine OS type
func pingHost(ipAddress string) (bool, error) {
	pingHostThrice := exec.Command("ping", "-c 3", ipAddress)
	stdout, err := pingHostThrice.CombinedOutput()
	if err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		fmt.Fprintf(os.Stdout, "Unable to fully execute `%s %s`\n", "ping -c 3 ", ipAddress)
		return false, err
	}

	fmt.Fprintln(os.Stdout, "---=== Ping Results ===---\n", string(stdout))

	time.Sleep(1 * time.Second)
	fmt.Fprintf(os.Stdout, "Completed attempts to ping host, additional reminder to screenshot ping.png for notes")

	return true, nil
}

func testWebserverConnectivity(protocol, ipAddress string, ctx context.Context) (bool, error) {
	requestURL := fmt.Sprintf("%s://%s", protocol, ipAddress)
	req, err := http.NewRequestWithContext(ctx, "GET", requestURL, nil)
	if err != nil {
		fmt.Printf("Request creation failed: %v\n", err)
		os.Exit(1)
	}
	req.Header.Set("User-Agent", "Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0")

	res, err := http.DefaultClient.Do(req)
	if err != nil {
		fmt.Fprintln(os.Stderr, "Client Error making http request:", err)
		return false, err
	}

	fmt.Fprintf(os.Stdout, "client: status code: %d\n", res.StatusCode)
	if res.StatusCode != 200 {
		return false, nil
	} else {
		return true, nil
	}
}

// Use first test connectivity with curl and then to download the http and https root webpages
func downloadWebRootSource(ipAddress, protocol string) error {
	requestURL := fmt.Sprintf("%s://%s", protocol, ipAddress)
	outputFile := fmt.Sprintf("%s-www-root.html", protocol)
	curlWebRootHTTP := exec.Command("curl", requestURL, "-o", outputFile)
	curlWebRootHTTP.Stdout = os.Stdout
	curlWebRootHTTP.Stderr = os.Stderr

	if err := curlWebRootHTTP.Run(); err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		fmt.Fprintf(os.Stdout, "Unable to execute `%s %s`\n", "curl", cmdArgs)
		return err
	}

	time.Sleep(1 * time.Second)
	fmt.Fprintf(os.Stdout, "Completed attempts to download the web root with curl %s://%s", protocol, ipAddress)

	return nil
}

func main() {
	gracefulShutdown := make(chan os.Signal, 1)
	signal.Notify(gracefulShutdown, syscall.SIGINT, syscall.SIGTERM)
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

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

	if ipAddress == "" || strings.Count(ipAddress, ".") != 3 {
		err := fmt.Errorf("Invalid or no IP Address provided: %v", os.Args)
		fmt.Fprintln(os.Stderr, "Error:", err)
		os.Exit(-1)
	}

	connect, err := pingHost(ipAddress)
	if connect != true || err != nil {
		err := fmt.Errorf("Initial pinging of target failed, connectivity %v", connect)
		fmt.Fprintln(os.Stderr, "Error:", err)
		os.Exit(-1)
	}

	httpConnect, err := testWebserverConnectivity("http", ipAddress, ctx)
	if err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
	}

	httpsConnect, err := testWebserverConnectivity("http", ipAddress, ctx)
	if err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
	}

	if httpConnect {
		downloadWebRootSource(ipAddress, "http")
		if err != nil {
			fmt.Fprintln(os.Stderr, "Error:", err)
		}
	}

	if httpsConnect {
		downloadWebRootSource(ipAddress, "https")
		if err != nil {
			fmt.Fprintln(os.Stderr, "Error:", err)
		}
	}

	<-gracefulShutdown
	_, cancel = context.WithTimeout(context.Background(), 3*time.Second)
	defer handleTermination(cancel)
	os.Exit(0)
}
