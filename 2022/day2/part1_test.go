package day2

import (
	"testing"
)

func TestCalculateOutcome(t *testing.T) {
	testCases := [][]string{{"A", "Y"}, {"B", "X"}, {"C", "Z"}}
	want := []int{8, 1, 6}

	var got int
	for i := 0; i < len(testCases); i++ {
		got = CalculateOutcome(testCases[i][0], testCases[i][1])

		if got != want[i] {
			t.Errorf("got %d want %d", got, want[i])
		}

	}
}

func TestReadInput(t *testing.T) {
	got := ReadInput("example_input")
	want := 15

	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}
