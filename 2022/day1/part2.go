package day1

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
)

func ThreeMaxCalories(filename string) (int, error) {
	if filename == "" {
		return 0, fmt.Errorf("file not given")
	}

	file, err := os.Open(filename)
	if err != nil {
		return 0, err
	}
	scanner := bufio.NewScanner(file)

	var currCalories int
	threeMaxCalories := make([]int, 3)
	for scanner.Scan() {
		if scanner.Text() == "" {
			if currCalories >= threeMaxCalories[0] {
				threeMaxCalories[0] = currCalories
				sort.Slice(threeMaxCalories, func(i, j int) bool { return threeMaxCalories[j] > threeMaxCalories[i] })
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

	fmt.Println(threeMaxCalories)
	return SumSlice(threeMaxCalories), nil
}

func SumSlice(slice []int) (sum int) {
	for _, value := range slice {
		sum += value
	}

	return
}
