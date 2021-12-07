package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

type point struct {
	x int
	y int
}

type line struct {
	begin point
	end   point
}

const filename = "input.txt"

func readInput(filename string) (lines []line) {
	file, err := os.Open(filename)
	if err != nil {
		log.Panic()
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		var begin, end point
		initialSplit := strings.Split(scanner.Text(), " ")
		beginCoordinates := strings.Split(initialSplit[0], ",")
		endCoordinates := strings.Split(initialSplit[2], ",")
		begin.x, _ = strconv.Atoi(beginCoordinates[0])
		begin.y, _ = strconv.Atoi(beginCoordinates[1])
		end.x, _ = strconv.Atoi(endCoordinates[0])
		end.y, _ = strconv.Atoi(endCoordinates[1])

		lines = append(lines, line{begin, end})
	}
	return lines
}

func addScore(input line, grid [991][991]int) [991][991]int {
	if input.begin.x == input.end.x || input.begin.y == input.end.y {
		if input.begin.y > input.end.y {
			for i := input.end.y; i <= input.begin.y; i++ {
				grid[input.begin.x][i] += 1
			}
		} else if input.begin.x > input.end.x {
			for i := input.end.x; i <= input.begin.x; i++ {
				grid[i][input.begin.y] += 1
				}
		} else if input.begin.x < input.end.x {
			for i := input.begin.x; i <= input.end.x; i++ {
				grid[i][input.begin.y] += 1
				}
		} else if input.begin.y < input.end.y {
			for i := input.begin.y; i <= input.end.y; i++ {
				grid[input.begin.x][i] += 1
			}
		}
	} else if {
		return grid
	}
	return grid
}

func calculate(grid [991][991]int) (result int) {
	for _, row := range grid {
		for _, number := range row {
			if number > 1 {
				result++
			}
		}
	}
	return result
}
func main() {
	grid := [991][991]int{}
	lines := readInput(filename)
	for _, line := range lines {
		grid = addScore(line, grid)
	}
	answer := calculate(grid)
	fmt.Printf("%d", answer)
}
