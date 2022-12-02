package day2

import (
	"bufio"
	"os"
	"strings"
)

var outcomes = map[string]map[string]int{
	"X": { // Rock outcomes
		"A": 4,
		"B": 1,
		"C": 7,
	},
	"Y": { // Paper outcomes
		"A": 8,
		"B": 5,
		"C": 2,
	},
	"Z": { // Scissors outcomes
		"A": 3,
		"B": 9,
		"C": 6,
	},
}

func ReadInput(filename string) int {
	var sum int
	file, err := os.Open(filename)
	if err != nil {
		panic(err)
	}
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		values := strings.Split(scanner.Text(), " ")
		sum += CalculateOutcome(values[0], values[1])
	}

	return sum

}

func CalculateOutcome(first, second string) int {
	return outcomes[second][first]
}
