package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

const filename = "input.txt"

func main() {
	input := readInput(filename)
	var count int
	fmt.Println(len(input))
	for _, word := range input {
		if len(word) == 2 || len(word) == 3 || len(word) == 4 || len(word) == 7 {
			count++
		}
	}
	fmt.Printf("%d\n", count)
}

func readInput(filename string) (input []string) {
	file, err := os.Open(filename)
	if err != nil {
		log.Panic(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		relevantLines := strings.Split(scanner.Text(), " | ")[1]
		lines := strings.Split(relevantLines, " ")
		fmt.Println(lines)
		input = append(input, lines...)
	}
	return
}
