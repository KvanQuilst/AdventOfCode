def h_symmetry(pattern):
    sum = 0
    for i, l in enumerate(pattern[1:], 1):
        sym = True
        for j in range(0, i):
            if i + j >= len(pattern) or i-j-1 < 0:
                break

            if pattern[i+j] != pattern[i-j-1]:
                sym = False
                break

        if sym:
            sum += 100 * i

    return sum


def v_symmetry(pattern):
    sum = 0
    for i, l in enumerate(pattern[0][1:-1], 1):
        sym = True
        for j in range(0, i):
            if i + j >= len(pattern[0])-1 or i-j-1 < 0:
                break

            if [x[i+j] for x in pattern] != [x[i-j-1] for x in pattern]:
                sym = False
                break
            
        if sym:
            sum += i

    return sum


def h_sym_smudge(pattern):
    sum = 0
    for i, l in enumerate(pattern[1:], 1):
        sym = True
        diff_1 = False
        for j in range(0, i):
            if i + j >= len(pattern) or i-j-1 < 0:
                break

            p1 = pattern[i+j]
            p2 = pattern[i-j-1]
            diff = len([1 for x in zip(p1, p2) if x[0] != x[1]])
            if diff == 1:
                diff_1 = True

            if p1 != p2 and diff > 1:
                sym = False
                break

        if sym and diff_1:
            sum = 100 * i

    return sum


def v_sym_smudge(pattern):
    sum = 0
    for i, l in enumerate(pattern[0][1:-1], 1):
        sym = True
        diff_1 = False
        for j in range(0, i):
            if i + j >= len(pattern[0])-1 or i-j-1 < 0:
                break

            p1 = [x[i+j] for x in pattern]
            p2 = [x[i-j-1] for x in pattern]
            diff = len([1 for x in zip(p1, p2) if x[0] != x[1]])
            if diff == 1:
                diff_1 = True

            if p1 != p2 and diff > 1:
                sym = False
                break
            
        if sym and diff_1:
            sum = i

    return sum


def part1():
    print("Advent of Code 2023: Day 13.1")

    sum = 0
    with open("day13.in", 'r') as file:
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

    sum = 0
    with open("day13.in", 'r') as file:
        lines = file.readlines()

        # Horizontal
        pattern = []
        for line in lines:
            if not line.isspace():
                pattern.append(line)

            else:
                sum += h_sym_smudge(pattern) + v_sym_smudge(pattern)
                pattern = []

        sum += h_sym_smudge(pattern) + v_sym_smudge(pattern)

        print("The sum is", sum)


if __name__ == "__main__":
    part1()
    print()
    part2()
