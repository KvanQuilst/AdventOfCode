def count(line):
    sum = 0

    dig = 0
    for c in line:
        if c.isdigit():
            if dig == 0:
                sum += 10 * int(c)
            dig = int(c)
    sum += dig

    return sum


def part_1():
    print("Advent of Code 2023, Day 1.1")

    sum = 0
    with open("day1.in", 'r') as file:
        lines = file.readlines()

        for line in lines:
            sum += count(line)

    print("The sum is ", sum)


def part_2():
    print("Advent of Code 2023, Day 1.2")

    nums = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    sum = 0

    with open("day1.in", 'r') as file:
        lines = file.readlines()

        for line in lines:
            digs = []
            for i in range(len(line)):
                if line[i].isdigit():
                    digs.append(int(line[i]))
                for j in range(len(nums)):
                    if line[i:].startswith(nums[j]):
                        digs.append(j+1)
            sum += digs[0] * 10 + digs[-1]

    print("The sum is ", sum)


if __name__ == "__main__":
    part_1()
    print()
    part_2()
