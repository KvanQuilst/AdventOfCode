def part1():
    print("Advent of Code 2023: Day 11.1")

    sum = 0
    with open("day11_test.in", 'r') as file:
        universe = [list(x.strip()) for x in file.readlines()]
        
        lines = []
        for idx, line in enumerate(universe):
            if all([x == '.' for x in line]):
                lines.append(idx)

        count = 0
        for line in lines:
            universe.insert(line, ['.' for x in universe[0]])



def part2():
    print("Advent of Code 2023: Day 11.2")

    with open("day11_test.in", 'r') as file:
        lines = file.readlines()


if __name__ == "__main__":
    part1()
    print()
    part2()
