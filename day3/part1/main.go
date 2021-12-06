package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
)

func main() {
	var delta string
	var lines int
	var deltaInt, epsilonInt int
	file, err := os.Open("input.txt")
	if err != nil {
		log.Panic(err)
	}
	activatedBitFrequency := make([]int, 12)
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		for i, bit := range scanner.Text() {
			if bit == '1' {
				activatedBitFrequency[i]++
			}
		}
		lines++
	}
	for _, activatedBits := range activatedBitFrequency {
		if activatedBits > (lines / 2) {
			delta = delta + "1"
		} else {
			delta = delta + "0"
		}
	}
	for i, bit := range delta {
		bitInt, err := strconv.Atoi(string(bit))
		if err != nil {
			log.Panic(err)
		}
		if bitInt == 1 {
			deltaInt = deltaInt + int(math.Pow(float64(2), float64(len(delta)-(i+1))))
		} else {
			epsilonInt = epsilonInt + int(math.Pow(float64(2), float64(len(delta)-(i+1))))
		}
	}
	fmt.Printf("The answer is: %d", epsilonInt*deltaInt)
}
