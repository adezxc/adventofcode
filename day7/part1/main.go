package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
	"strings"
)

const filename = "input.txt"

func main() {
	input := readInput(filename)
	median := CalcMedian(input)
	fmt.Println(median)
	answer := 0
	for _, number := range input {
		answer += findDiff(number, median)
	}
	fmt.Printf("%d\n", answer)
}

func CalcMedian(input []int) int {
	sort.Ints(input) // sort the numbers

	mNumber := len(input) / 2

	if len(input)%2 != 0 {
		return input[mNumber]
	}

	return (input[mNumber-1] + input[mNumber]) / 2
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
