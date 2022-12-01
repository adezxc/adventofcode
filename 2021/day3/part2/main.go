package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"time"
)

func main() {
	var lines int
	//var oxygenRating, CO2ScrubberRating int
	var mostFrequent, leastFrequent string
	var trimIndices, trimIndices2 []int
	start := time.Now()
	file, err := os.Open("input.txt")
	if err != nil {
		log.Panic(err)
	}
	var oxygenSlice, CO2Slice []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		oxygenSlice = append(oxygenSlice, scanner.Text())
		CO2Slice = append(CO2Slice, scanner.Text())
		lines++
	}
	//fmt.Println(mostFrequent)
	for j := 0; j < len(oxygenSlice[0]); j++ {
		mostFrequent = most(oxygenSlice, len(oxygenSlice[0]), j)
		leastFrequent = least(CO2Slice, len(CO2Slice[0]), j)
		for i := 0; i < len(oxygenSlice); i++ {
			if oxygenSlice[i][j] != mostFrequent[0] {
				trimIndices = append(trimIndices, i)
			}
		}
		for i := 0; i < len(CO2Slice); i++ {
			if CO2Slice[i][j] != leastFrequent[0] {
				trimIndices2 = append(trimIndices2, i)
			}
		}
		oxygenSlice = trimSlice(oxygenSlice, trimIndices)
		CO2Slice = trimSlice(CO2Slice, trimIndices2)
		trimIndices2 = nil
		trimIndices = nil
		//fmt.Println(len(oxygenSlice))
	}
	oxygenRating, _ := strconv.ParseInt(oxygenSlice[0], 2, 32)
	CO2Rating, _ := strconv.ParseInt(CO2Slice[0], 2, 32)
	fmt.Printf("%d\n", oxygenRating*CO2Rating)
	fmt.Printf("Time it took to run this: %f milliseconds", float64(time.Since(start))/1000000)
}
func remove(slice []string, s int) []string {
	return append(slice[:s], slice[s+1:]...)
}

func decrement(slice []int) []int {
	for i := 0; i < len(slice); i++ {
		slice[i]--
	}
	return slice
}

func trimSlice(slice []string, indices []int) []string {
	for i := 0; i < len(indices); i++ {
		if len(slice) == 1 {
			return slice
		}
		slice = remove(slice, indices[i])
		indices = decrement(indices)
	}
	return slice
}

func most(slice []string, length int, pos int) (mostFrequent string) {
	var activatedBits int
	for _, bits := range slice {
		if bits[pos] == '1' {
			activatedBits++
		}
	}
	if float64(activatedBits) >= float64(float64(len(slice))/2) {
		mostFrequent = "1"
	} else {
		mostFrequent = "0"
	}
	//fmt.Println(mostFrequent)
	return
}

func least(slice []string, length int, pos int) (mostFrequent string) {
	var activatedBits int
	for _, bits := range slice {
		if bits[pos] == '1' {
			activatedBits++
		}
	}
	if float64(activatedBits) >= float64(float64(len(slice))/2) {
		mostFrequent = "0"
	} else {
		mostFrequent = "1"
	}
	//fmt.Println(mostFrequent)
	return
}
