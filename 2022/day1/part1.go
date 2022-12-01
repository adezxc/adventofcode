package day1

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func MaxCalories(filename string) (max int, err error) {
	if filename == "" {
		return 0, fmt.Errorf("file not given")
	}

	file, err := os.Open(filename)
	if err != nil {
		return 0, err
	}
	scanner := bufio.NewScanner(file)

	var currCalories int

	for scanner.Scan() {
		if scanner.Text() == "" {
			if currCalories >= max {
				max = currCalories
			}

			currCalories = 0
			continue
		}
		calories, err := strconv.Atoi(scanner.Text())
		if err != nil {
			return 0, err
		}
		currCalories += calories
	}

	return
}
