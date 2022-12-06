package day6

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestFirstMarker(t *testing.T) {
	got := firstMarker("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 4)
	want := 7

	assert.Equal(t, want, got, "must be equal to 7")

	got = firstMarker("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 14)
	want = 19

	assert.Equal(t, want, got, "must be equal to 29")
}

func TestReadInput(t *testing.T) {
	readInput("input.txt")
}
