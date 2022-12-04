package day4

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestUnwrap(t *testing.T) {
	got := Unwrap("2-20,3-3")
	want := []int{2, 4, 6, 8}

	assert.Equal(t, got, want, "they should be equal")
}

func TestRanges(t *testing.T) {
	got1, got2 := Ranges([]int{2, 4, 6, 8})
	want1 := []int{2, 3, 4}
	want2 := []int{6, 7, 8}

	assert.Equal(t, got1, want1, "they should be equal")
	assert.Equal(t, got2, want2, "they should be equal")
}

func TestOverlapFully(t *testing.T) {
	got := OverlapFully([]int{2, 3, 4, 5}, []int{3, 4})
	want := true

	assert.Equal(t, got, want, "they should be equal")
}

func TestOverlap(t *testing.T) {
	got := Overlap([]int{2, 3, 4, 5}, []int{3, 4, 5, 6})
	want := true

	assert.Equal(t, got, want, "they should be equal")
}

func TestInput(t *testing.T) {
	got := readInput("example_input")
	want := 4

	assert.Equal(t, got, want, "they should be equal")

	got = readInput("input")
	want = 599

	assert.Equal(t, got, want, "the answer of part 1 is %d", got)
}
