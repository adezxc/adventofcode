package day5

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGetOrder(t *testing.T) {
	gotSrc, gotDst, gotN := getOrder("move 5 from 1 to 3")
	wantSrc, wantDst, wantN := 1, 3, 5

	assert.Equal(t, wantSrc, gotSrc, "they should be equal")
	assert.Equal(t, wantDst, gotDst, "they should be equal")
	assert.Equal(t, wantN, gotN, "they should be equal")
}

func TestReadInput(t *testing.T) {
	readInput("input.txt")

	assert.Equal(t, 123, 222, "lmao")
}
