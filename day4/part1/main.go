package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

const filename = "input.txt"

type BingoTable struct {
	numbers        [5][5]int
	checkedNumbers [5][5]bool
}

func readInput(fileName string) (bingoInput []int, bingoTables []BingoTable) {
	whichTable := -1
	whichRow := 0
	file, err := os.Open(fileName)
	if err != nil {
		log.Panic(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	scanner.Scan()
	bingoNumbersInString := strings.Split(scanner.Text(), ",")
	var bingoNumbers []int
	for _, number := range bingoNumbersInString {
		numberInt, err := strconv.Atoi(number)
		if err != nil {
			log.Panic(err)
		}
		bingoNumbers = append(bingoNumbers, numberInt)
	}
	for scanner.Scan() {
		if scanner.Text() == "" {
			var table BingoTable
			bingoTables = append(bingoTables, table)
			whichTable++
			whichRow = 0
			continue

		} else {
			numberString := strings.TrimSpace(strings.Replace(scanner.Text(), "  ", " ", -1))
			numbers := strings.Split(numberString, " ")
			for i, numberStr := range numbers {
				number, err := strconv.Atoi(numberStr)
				if err != nil {
					log.Panic(err)
				}
				bingoTables[whichTable].numbers[whichRow][i] = number
			}
			whichRow++
		}

	}
	return bingoNumbers, bingoTables
}

func updateTable(table BingoTable, number int) BingoTable {
	for i := 0; i < 5; i++ {
		for j := 0; j < 5; j++ {
			if table.numbers[i][j] == number {
				table.checkedNumbers[i][j] = true
			}
		}
	}
	return table
}

func checkTable(table BingoTable) bool {
	for i := 0; i < 5; i++ {
			if table.checkedNumbers[i][0] {
				if table.checkedNumbers[i][1] && table.checkedNumbers[i][2] && table.checkedNumbers[i][3] && table.checkedNumbers[i][4] {
					return true
				}
			}
			if table.checkedNumbers[0][i] {
				if table.checkedNumbers[1][i] && table.checkedNumbers[2][i] && table.checkedNumbers[3][i] && table.checkedNumbers[4][i] {
					return true
				}
			}
		}
	return false
}

func calculateWonTable(table BingoTable) (sum int) {
	for i := 0; i < 5; i++ {
		for j := 0; j < 5; j++ {
			if !table.checkedNumbers[i][j] {
				sum += table.numbers[i][j]
			}
		}
	}
	return
}

func main() {
	bingoInput, bingoTables := readInput(filename)

	for _, number := range bingoInput {
		for i := 0; i < len(bingoTables); i++ {
			bingoTables[i] = updateTable(bingoTables[i], number)
			if checkTable(bingoTables[i]) {
				fmt.Printf("%d\n", number*calculateWonTable(bingoTables[i]))
				return
			}
		}
	}
}
