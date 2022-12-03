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

	var sum, sumBadges, curr int
	lines := make([]string, 3)

	for scanner.Scan() {
		sum += priority(scanner.Text())
		lines[curr] = scanner.Text()
		curr++
		if curr == 3 {
			sumBadges += commonBadge(lines)
		}
		curr = curr % 3
	}

	fmt.Printf("The sum of all the ruckpack common items is %d\n", sum)
	fmt.Printf("The sum of all the ruckpack badges is %d\n", sumBadges)
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

func commonBadge(lines []string) int {
	items := make(map[rune][3]bool)

	var test [3]bool

	test[1] = false

	for _, val := range lines[0] {
		items[val] = [3]bool{true, false, false}
	}

	for _, val := range lines[1] {
		if value, ok := items[val]; ok {
			temp := value
			temp[1] = true
			items[val] = temp
		}
	}

	for _, val := range lines[2] {
		if value, ok := items[val]; ok {
			temp := value
			temp[2] = true
			items[val] = temp
		}
	}

	for key, value := range items {
		if value[0] && value[1] && value[2] {
			return calculatePriority(key)
		}
	}

	return 0
}

func calculatePriority(letter rune) int {
	if letter <= 90 {
		return int(letter) - 38
	}

	return int(letter) - 96
}
