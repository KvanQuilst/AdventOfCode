def post_diff(seq):
    n_seq = [0 for x in seq[1:]]
    for idx, val in enumerate(seq[1:], 0):
        n_seq[idx] = val - seq[idx]

    if all([x == 0 for x in n_seq]):
        return seq[-1]
    else:
        return seq[-1] + post_diff(n_seq)


def pre_diff(seq):
    n_seq = [0 for x in seq[1:]]
    for idx, val in enumerate(seq[1:], 0):
        n_seq[idx] = val - seq[idx]

    if all([x == 0 for x in n_seq]):
        return seq[0]
    else:
        return seq[0] - pre_diff(n_seq)


def part1():
    print("Advent of Code 2023, Day 9.1")

    sum = 0
    with open("day9.in", 'r') as file:
        lines = file.readlines()

        for line in lines:
            sum += post_diff([int(x) for x in line.split()])

    print("The sum is", sum)


def part2():
    print("Advent of Code 2023, Day 9.2")

    sum = 0
    with open("day9.in", 'r') as file:
        lines = file.readlines()

        for line in lines:
            sum += pre_diff([int(x) for x in line.split()])

    print("The sum is", sum)

if __name__ == "__main__":
    part1()
    print()
    part2()
