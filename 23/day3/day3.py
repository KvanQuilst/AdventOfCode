def part1():
    print("Advent of Code 2023, Day 3.1")

    sum = 0
    with open("day3.in", 'r') as file:
        lines = file.readlines()

        dig = 0
        symbols = "!@#$%^&*()-=+/"

        i = 0
        j = 0
        while i < len(lines):
            while j < len(lines[0]):
                if lines[i][j].isdigit():
                    s = j
                    while lines[i][j].isdigit() or j == len(lines[0]):
                        j += 1
                    dig = int(lines[i][s:j])

                    add = 0
                    for x in range(i-1, i+2):
                        for y in range(s-1, j+1):
                            if x >= 0 and x < len(lines) and y >= 0 and y < len(lines[0]):
                                if lines[x][y] in symbols:
                                    add = dig
                    sum += add
                j += 1
            j = 0
            i += 1
    print("The sum is", sum)


def part2():
    print("Advent of Code 2023, Day 3.2")


if __name__ == "__main__":
    part1()
    print()
    part2()
