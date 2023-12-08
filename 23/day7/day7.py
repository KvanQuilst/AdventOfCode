def part1():
    print("Advent of Code 2023, Day 7.1")

    cards = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2']

    with open("day7_test.in", 'r') as file:
        lines = file.readlines()

        hands = [(x[0], int(x[1])) for x in [line.split() for line in lines]]
        

        print("The sum is", sum)

def part2():
    print("Advent of Code 2023, Day 7.2")


if __name__== "__main__":
    part1()
    print()
    part2()
