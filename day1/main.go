package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"time"
)

func main() {
	start := time.Now()
	file, err := os.Open("input.txt")
	if err != nil {
		log.Panic(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var a, b, c int
	initialSum := 0
	count := -2
	counter := 0
	for scanner.Scan() {
		number, err := strconv.Atoi(scanner.Text())
		if err != nil {
			log.Panic(err)
		}
		if counter == 0 {
			a = number
			counter++
		} else if counter == 1 {
			b = number
			counter++
		} else if counter == 2 {
			c = number
			counter = 0
		}
		if a+b+c > initialSum {
			initialSum = a + b + c
			count++
		} else {
			initialSum = a + b + c
		}
		
	}
	fmt.Printf("Time since start: %d\n", time.Since(start)/1000)
	fmt.Println(count)
}
