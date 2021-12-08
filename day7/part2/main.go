package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"sort"
	"strconv"
	"strings"
)

const filename = "input.txt"

func main() {
	input := readInput(filename)
	average := CalcAverage(input)
	answer := 0
	for _, number := range input {
		answer += findWithIncrement(findDiff(number, average))
	}
	fmt.Printf("%d\n", answer)
}

func findWithIncrement(n int) int {
	if (n > 0) {
		return n + findWithIncrement(n-1)
	} else {
		return 0
	}
}

func CalcAverage(input []int) (result int) {
	for _, number := range input {
		result += number
	}
	return int(math.Round(float64(result / len(input))))
}

func findDiff(position, average int) int {
	return Abs(position - average)
}

func Abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func readInput(filename string) (input []int) {
	file, err := os.Open(filename)
	if err != nil {
		log.Panic(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	scanner.Scan()
	inputStr := strings.Split(scanner.Text(), ",")
	for _, number := range inputStr {
		numberInt, err := strconv.Atoi(number)
		if err != nil {
			log.Panic(err)
		}
		input = append(input, numberInt)
	}
	return
}
