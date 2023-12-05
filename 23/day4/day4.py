def part1():
    print("Advent of Code 2023, Day 4.1")

    sum = 0
    with open("day4.in", 'r') as file:
        lines = file.readlines()

        for line in lines:
            matches = 0
            
            line = line.split(":")[1].split("|")
            winners = [int(x) for x in line[0].split()]
            nums = [int(x) for x in line[1].split()]

            for num in nums:
                if num in winners:
                    matches += 1

            if matches > 0:
                sum += 2 ** (matches - 1)

    print("The sum is", sum)


def part2():
    print("Advent of Code 2023, Day 4.2")

    sum = 0
    with open("day4.in", 'r') as file:
        lines = file.readlines()

        copies = [1 for x in lines]
        scratchers = len(lines) 

        for i in range(len(lines)):

            line = lines[i].split(":")[1].split("|")
            winners = [int(x) for x in line[0].split()]
            nums = [int(x) for x in line[1].split()]

            num_win = 0
            for num in nums:
                if num in winners:
                    num_win += 1
                    
            scratchers += num_win * copies[i]
            copies[i+1:i+1+num_win] = [x + (1 * copies[i]) for x in copies[i+1:i+1+num_win] ]

    print("The number of scratchers is:", scratchers)


if __name__ == "__main__":
    part1()
    print()
    part2()
