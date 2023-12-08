import re

def part1():
    print("Advent of Code 2023, Day 8.1")

    steps = 0
    with open("day8.in", 'r') as file:
        lines = file.readlines()

        dirs = lines[0].strip()

        network = [re.split(' = \(|, |\)', line[:-2]) for line in lines[2:]]
        network = map(lambda x: (x[0], (x[1], x[2])), network)
        network = dict(network)

        curr = 'AAA'
        dir_idx = 0

        while curr != 'ZZZ':
            if dirs[dir_idx] == 'L':
                curr = network[curr][0]
            else: # R
                curr = network[curr][1]
            dir_idx = (dir_idx + 1) % len(dirs)
            steps += 1

    print("The number of steps is", steps)

def part2():
    print("Advent of Code 2023, Day 8.2")

    with open("day8_test.in", 'r') as file:
        lines = file.readlines()


if __name__ == "__main__":
    part1()
    print()
    part2()
