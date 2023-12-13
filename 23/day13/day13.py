def h_symmetry(pattern):
    sum = 0
    for i, l in enumerate(pattern[1:], 1):
        sym = True
        for j in range(0, i):
            if i + j >= len(pattern) or i-j-1 <= 0:
                break

            if not pattern[i+j] == pattern[i-j-1]:
                sym = False

        if sym:
            sum += 100

    return sum


def v_symmetry(pattern):
    sum = 0
    return sum


def part1():
    print("Advent of Code 2023: Day 13.1")

    sum = 0
    with open("day13_test.in", 'r') as file:
        lines = file.readlines()

        # Horizontal
        pattern = []
        for line in lines:
            if not line.isspace():
                pattern.append(line)

            else:
                sum += h_symmetry(pattern) + v_symmetry(pattern)
                pattern = []

        sum += h_symmetry(pattern) + v_symmetry(pattern)

        print("The sum is", sum)


def part2():
    print("Advent of Code 2023: Day 13.2")

    with open("day13_test.in", 'r') as file:
        lines = file.readlines()


if __name__ == "__main__":
    part1()
    print()
    part2()
