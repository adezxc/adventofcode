package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

const filename = "testinput.txt"


func main() {
	fish := readInput(filename)
	for i := 0; i < 256; i++ {
		newDay(&fish, uint64(len(fish)))
		
	}
	fmt.Printf("The result is %d", len(fish))
}

func newDay(fish *[]int, howManyFish uint64) {
	var i uint64 = 0
	for i = 0; i < howManyFish; i++ {
			if (*fish)[i] > 0 {
				(*fish)[i]--
			} else {
				(*fish)[i] = 6
				*fish = append(*fish, 8)
			}
			
	}
	fmt.Println(howManyFish)
}

func readInput(filename string) (fish []int) {
	file, err := os.Open(filename)
	if err != nil {
		log.Panic(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	scanner.Scan()
	numbers := strings.Split(scanner.Text(), ",")
	for _, number := range numbers {
		days, err := strconv.Atoi(number)
		if err != nil {
			log.Panic(err)
		}
		fish = append(fish, days)
	}
	return
}
