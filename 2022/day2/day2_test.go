package day2

import (
	"testing"
)

func TestCalculateOutcomePart1(t *testing.T) {
	testCases := [][]string{{"A", "Y"}, {"B", "X"}, {"C", "Z"}}
	want := []int{8, 1, 6}

	var got int
	for i := 0; i < len(testCases); i++ {
		got = CalculateOutcome(testCases[i][0], testCases[i][1], part1_outcomes)

		if got != want[i] {
			t.Errorf("got %d want %d", got, want[i])
		}

	}
}

func TestCalculateOutcomePart2(t *testing.T) {
	testCases := [][]string{{"A", "Y"}, {"B", "X"}, {"C", "Z"}}
	want := []int{4, 1, 7}

	var got int
	for i := 0; i < len(testCases); i++ {
		got = CalculateOutcome(testCases[i][0], testCases[i][1], part2_outcomes)

		if got != want[i] {
			t.Errorf("got %d want %d", got, want[i])
		}

	}
}

func TestReadInput(t *testing.T) {
	got := ReadInput("example_input", part1_outcomes)
	want := 15

	if got != want {
		t.Errorf("got %d want %d", got, want)
	}

	got = ReadInput("example_input", part2_outcomes)
	want = 12

	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}
