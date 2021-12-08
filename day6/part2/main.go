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


func main() {
	fish := readInput(filename)
	for i := 0; i < 256; i++ {
		fish = newDay(fish)
		fmt.Println(fish)
	}
	fmt.Printf("The result is %d\n", howMany(fish))
}

func newDay(fish map[int]uint64) map[int]uint64 {
	newFish := make(map[int]uint64)
	newFish[0] = fish[1]
	newFish[1] = fish[2]
	newFish[2] = fish[3]
	newFish[3] = fish[4]
	newFish[4] = fish[5]
	newFish[5] = fish[6]
	newFish[6] = fish[7]+fish[0]
	newFish[7] = fish[8]
	newFish[8] = fish[0]
	return newFish
}

func howMany(fish map[int]uint64) (sum uint64) {
	for i := range fish {
		sum += fish[i]
	}
	return
}

func readInput(filename string) map[int]uint64 {
	file, err := os.Open(filename)
	fish := make(map[int]uint64)
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
		if _, ok := fish[days]; ok {
			fish[days]++
		} else {
			fish[days] = 1
		}
	}
	return fish
}
