package day5

import (
	"bufio"
	"fmt"
	"os"
)

//     [C]             [L]         [T]
//     [V] [R] [M]     [T]         [B]
//     [F] [G] [H] [Q] [Q]         [H]
//     [W] [L] [P] [V] [M] [V]     [F]
//     [P] [C] [W] [S] [Z] [B] [S] [P]
// [G] [R] [M] [B] [F] [J] [S] [Z] [D]
// [J] [L] [P] [F] [C] [H] [F] [J] [C]
// [Z] [Q] [F] [L] [G] [W] [H] [F] [M]
//  1   2   3   4   5   6   7   8   9

var inputStrings = []string{
	"ZJG",
	"QLRPWFVC",
	"FPMCLGR",
	"LFBWPHM",
	"GCFSVQ",
	"WHJZMQTL",
	"HFSBV",
	"FJZS",
	"MCDPFHBT",
}

func readInput(filename string) {
	file, err := os.Open(filename)
	if err != nil {
		panic(err)
	}

	defer file.Close()

	scanner := bufio.NewScanner(file)

	inputPart1 := make([]string, len(inputStrings))
	inputPart2 := make([]string, len(inputStrings))
	copy(inputPart1, inputStrings)
	copy(inputPart2, inputStrings)
	for scanner.Scan() {
		src, dst, n := getOrder(scanner.Text())
		makeOrder(inputPart1, src, dst, n)
		moveTwo(inputPart2, src, dst, n)
	}

	for i := 0; i < len(inputPart1); i++ {
		letter1 := string(inputPart1[i][len(inputPart1[i])-1])
		if letter1 != "" {
			fmt.Printf("Part1: %s   ", letter1)
		}
		letter2 := string(inputPart2[i][len(inputPart2[i])-1])
		if letter2 != "" {
			fmt.Printf("Part2: %s   \n", letter2)
		}
	}
}

func getOrder(input string) (int, int, int) {
	var src, dst, n int

	fmt.Sscanf(input, "move %d from %d to %d", &n, &src, &dst)
	return src - 1, dst - 1, n
}

func makeOrder(input []string, src, dst, n int) {
	for i := 0; i < n; i++ {
		move(input, src, dst)
	}
}

func move(input []string, src, dst int) {
	input[dst] = input[dst] + string(input[src][len(input[src])-1])
	input[src] = input[src][0 : len(input[src])-1]
}

func moveTwo(input []string, src, dst, n int) {
	length := len(input[src])
	if length == 0 {
		return
	}
	if n >= length {
		input[dst] = input[dst] + input[src]
		input[src] = ""
		return
	}

	input[dst] = input[dst] + string(input[src][length-n:])
	input[src] = input[src][0 : length-n]
}
