package day4

import (
	"bufio"
	"os"
	"regexp"
	"strconv"
)

func readInput(filename string) int {
	file, err := os.Open(filename)
	if err != nil {
		panic(err)
	}

	defer file.Close()

	scanner := bufio.NewScanner(file)
	var howMany int

	for scanner.Scan() {
		if Overlap(Ranges(Unwrap(scanner.Text()))) {
			howMany++
		}
	}
	return howMany
}

func Unwrap(pair string) (indices []int) {
	r := regexp.MustCompile("^([0-9]+)-([0-9]+),([0-9]+)-([0-9]+)$")

	ranges := r.FindStringSubmatch(pair)
	for i := 1; i < 5; i++ {
		index, err := strconv.Atoi(ranges[i])
		if err != nil {
			panic(err)
		}
		indices = append(indices, index)
	}

	return
}

func Ranges(query []int) (first, second []int) {
	for i := query[0]; i <= query[1]; i++ {
		first = append(first, i)
	}
	for i := query[2]; i <= query[3]; i++ {
		second = append(second, i)
	}

	return
}

func Overlap(first, second []int) bool {
	if len(second) > len(first) {
		second, first = first, second
	}

	for _, value := range second {
		if Contains(first, value) {
			return true
		}
	}

	return false
}

func OverlapFully(first, second []int) bool {
	if len(second) > len(first) {
		second, first = first, second
	}

	for _, value := range second {
		if !Contains(first, value) {
			return false
		}
	}

	return true
}

func Contains(slice []int, value int) bool {
	for _, val := range slice {
		if value == val {
			return true
		}
	}

	return false
}
