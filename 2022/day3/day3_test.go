package day3

import "testing"

func TestPriority(t *testing.T) {
	got := priority("vJrwpWtwJgWrhcsFMMfFFhFp")
	want := 16

	if got != want {
		t.Errorf("got %d want %d given", got, want)
	}
}

func TestCalculatePriority(t *testing.T) {
	got := calculatePriority('a')
	want := 1

	if got != want {
		t.Errorf("got %d want %d given", got, want)
	}
}

func TestReadInput(t *testing.T) {
	readInput("example_input")

	readInput("input")
}
