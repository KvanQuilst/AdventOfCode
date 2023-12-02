def part1():
    print("Advent of Code 2023, Day 2.1")

    with open("day2.in", 'r') as file:
        lines = file.readlines()

        sum = 0
        for line in lines:
            line = line.split(':')
            game = int(line[0][4:])

            line = line[1].split(';')
            for pull in line:
                colors = pull.split(',')
                for color in colors:
                    if color.strip().endswith("red"):
                        if int(color.split()[0]) > 12:
                            game = 0
                    elif color.strip().endswith("blue"):
                        if int(color.split()[0]) > 14:
                            game = 0
                    elif color.strip().endswith("green"):
                        if int(color.split()[0]) > 13:
                            game = 0
            sum += game

    print("The sum is", sum)


def part2():
    print("Advent of Code 2023, Day 2.2")

    with open("day2.in", 'r') as file:
        lines = file.readlines()

        sum = 0
        for line in lines:
            line = line.split(':')[1].split(';')
            min_red = 0
            min_blue = 0
            min_green = 0
            for pull in line:
                colors = pull.split(',')
                for color in colors:
                    if color.strip().endswith("red"):
                        min_red = max(min_red, int(color.split()[0]))
                    elif color.strip().endswith("blue"):
                        min_blue = max(min_blue, int(color.split()[0]))
                    elif color.strip().endswith("green"):
                        min_green = max(min_green, int(color.split()[0]))
            sum += min_red * min_blue * min_green

    print("The sum is", sum)


if __name__ == "__main__":
    part1()
    print()
    part2()
