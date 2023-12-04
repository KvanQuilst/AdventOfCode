from functools import reduce

def part1():
    print("Advent of Code 2023, Day 3.1")

    sum = 0
    with open("day3.in", 'r') as file:
        lines = file.readlines()

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

    sum = 0
    with open("day3.in", 'r') as file:
        lines = file.readlines()

        grid = [[ 0 for i in range(len(lines[0]))] for j in range (len(lines))]

        i = 0
        j = 0
        while i < len(lines):
            while j < len(lines[0]):
                if lines[i][j].isdigit():
                    s = j
                    while lines[i][j].isdigit() or j == len(lines[0]):
                        j += 1
                    for x in range(s, j):
                        grid[i][x] = int(lines[i][s:j])

                elif lines[i][j] == '*':
                    grid[i][j] = -1
                    j += 1
                else:
                    j += 1
            j = 0
            i += 1

        i = 0
        j = 0
        while i < len(lines):
            while j < len(lines[0]):
                if grid[i][j] == -1:
                    mul = [] 
                    cnt = 0
                    for x in range(i-1, i+2):
                        for y in range(j-1, j+2):
                            if x >= 0 and x < len(grid) and y >= 0 and y < len(grid[0]) and grid[x][y] > 0 and not grid[x][y] in mul:
                                cnt += 1
                                mul.append(grid[x][y])
                    if cnt == 2:
                        sum += reduce((lambda x, y: x * y), mul)
                j += 1
            j = 0
            i += 1
    print("The sum is", sum)


if __name__ == "__main__":
    part1()
    print()
    part2()
