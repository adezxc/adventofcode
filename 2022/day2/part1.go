package day2

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

func CalculateOutcome(first, second string) int {
	return outcomes[second][first]
}
