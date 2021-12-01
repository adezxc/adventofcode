package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
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
		fmt.Printf("%d %d %d %d %d\n", a, b, c, a+b+c, initialSum)
		if a+b+c > initialSum {
			initialSum = a + b + c
			count++
		} else {
			initialSum = a + b + c
		}

	}
	fmt.Println(count)
}
