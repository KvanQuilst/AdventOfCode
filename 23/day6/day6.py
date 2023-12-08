def part1():
    print("Advent of Code 2023, Day 6.1")

    with open("day6.in", 'r') as file:
        lines = file.readlines()

        stats = [x for x in zip(map(int, lines[0].split(":")[1].split()),\
                                map(int, lines[1].split(":")[1].split()))]

        sum = 1
        for time, dist in stats:
            count = 0
            for i in range(time):
                if i * (time - i) > dist:
                    count += 1
            sum *= count

    print("The multiplied sum is:", sum)


def part2():
    print("Advent of Code 2023, Day 6.2")

    with open("day6.in", 'r') as file:
        lines = file.readlines()

        time = int(lines[0].split(":")[1].replace(" ", ""))
        dist = int(lines[1].split(":")[1].replace(" ", ""))

        count = 0
        for i in range(time):
            if i * (time - i) > dist:
                count += 1

    print("The number of ways is", count)


if __name__ == "__main__":
    part1()
    print()
    part2()
