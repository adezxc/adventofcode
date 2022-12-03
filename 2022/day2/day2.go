package day2

import (
	"bufio"
	"os"
	"strings"
)

var part1_outcomes = map[string]map[string]int{
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

// choices
// A - rock
// B - paper
// C - scissors
// X - lose
// Y - draw
// Z - WIN

var part2_outcomes = map[string]map[string]int{
	"X": { // Loss outcomes
		"A": 3,
		"B": 1,
		"C": 2,
	},
	"Y": { // Draw outcomes
		"A": 4,
		"B": 5,
		"C": 6,
	},
	"Z": { // Win outcomes
		"A": 8,
		"B": 9,
		"C": 7,
	},
}

func ReadInput(filename string, outcomes map[string]map[string]int) int {
	var sum int
	file, err := os.Open(filename)
	if err != nil {
		panic(err)
	}
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		values := strings.Split(scanner.Text(), " ")
		sum += CalculateOutcome(values[0], values[1], outcomes)
	}

	return sum

}

func CalculateOutcome(first, second string, outcomes map[string]map[string]int) int {
	return outcomes[second][first]
}
