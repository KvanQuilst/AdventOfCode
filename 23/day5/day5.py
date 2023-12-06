def part1():
    print("Advent of Code 2023, Day 5.1")

    with open("day5_test.in", 'r') as file:
        lines = file.readlines()

        seeds = [int(s) for s in lines[0].split(":")[1].split()]
        map = [(x, x, x, x, x, x, x, x) for x in seeds]

        l = 3
        for i in range(1, 8):
            while not lines[l].isspace():
                range = lines[l].split()     
                map = map(lambda m : range[0] + (m[i] - range[1]) if m[i] in range(range[1], range[1]+range[2] else m[i], map)
                l += 1
            l += 1


def part2():
    print("Advent of Code 2023, Day 5.2")


if __name__ == "__main__":
    part1()
    print()
    part2()
