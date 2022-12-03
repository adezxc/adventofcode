package day3

import (
	"bufio"
	"fmt"
	"os"
)

func readInput(filename string) {

	file, err := os.Open(filename)
	if err != nil {
		panic(err)
	}
	scanner := bufio.NewScanner(file)

	var sum int
	for scanner.Scan() {
		sum += priority(scanner.Text())
	}

	fmt.Printf("The sum of all the ruckpack common items is %d\n", sum)
}

func priority(rucksack string) int {
	compartments := []string{rucksack[0 : len(rucksack)/2], rucksack[len(rucksack)/2:]}
	items := make(map[rune]bool)
	commonItems := make([]rune, 0)
	for _, val := range compartments[0] {
		items[val] = true
	}

	for _, val := range compartments[1] {
		if unique, ok := items[val]; ok && unique {
			commonItems = append(commonItems, val)
			items[val] = false
		}
	}

	var sum int
	for _, item := range commonItems {
		sum += calculatePriority(item)
	}

	return sum
}

func calculatePriority(letter rune) int {
	if letter <= 90 {
		return int(letter) - 38
	}

	return int(letter) - 96
}
