package day6

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

	defer file.Close()

	scanner := bufio.NewScanner(file)
	scanner.Scan()

	fmt.Println(firstMarker(scanner.Text(), 4))
	fmt.Println(firstMarker(scanner.Text(), 14))
}

func firstMarker(input string, howMany int) int {
	letters := input[0:howMany]

	for i, letter := range input[howMany : len(input)-(howMany-1)] {
		if checkUnique(letters) {
			return i + howMany
		}
		letters = letters[1:howMany] + string(letter)
	}

	return 0
}

func checkUnique(letters string) bool {
	unique := map[rune]bool{}

	for _, letter := range letters {
		if _, val := unique[letter]; val {
			return false
		}
		unique[letter] = true
	}

	return true
}
