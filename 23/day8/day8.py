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
                #print(curr, "->", network[curr][0], dir_idx)
                curr = network[curr][0]
            else: # R
                #print(curr, "->", network[curr][1], dir_idx)
                curr = network[curr][1]
            dir_idx = (dir_idx + 1) % len(dirs)
            steps += 1

    print("The number of steps is", steps)

def part2():
    print("Advent of Code 2023, Day 8.2")

    steps = 0
    with open("day8.in", 'r') as file:
        lines = file.readlines()

        dirs = lines[0].strip()

        network = [re.split(' = \(|, |\)', line[:-2]) for line in lines[2:]]
        network = map(lambda x: (x[0], (x[1], x[2])), network)
        network = dict(network)

        curr = [x for x in network.keys() if x[2] == 'A']
        dir_idx = 0

        while not all(x[2] == 'Z' for x in curr):
            if dirs[dir_idx] == 'L':
                curr = [network[x][0] for x in curr]
            else:
                curr = [network[x][1] for x in curr]

            dir_idx = (dir_idx + 1) % len(dirs)
            steps += 1

    print("The number of steps is", steps)


if __name__ == "__main__":
    part1()
    print()
    part2()
