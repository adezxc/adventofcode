package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	var x, y, aim int
	file, err := os.Open("input.txt")
	if err != nil {
		log.Panic(err)
	}
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		instructions := strings.Split(scanner.Text(), " ")
		number, err := strconv.Atoi(instructions[1])
		if err != nil {
			log.Panic(err)
		}
		switch instructions[0] {
		case "forward":
			x += number
			y = y + (aim * number)
		case "down":
			aim += number
		case "up":
			aim -= number
		}
	}
	fmt.Printf("%d", x*y)
}
