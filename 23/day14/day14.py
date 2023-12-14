def roll_ns(platform, south):
    if south:
        platform.reverse()

    for idx, line in enumerate(platform):
        for jdx, rock in enumerate(line):
            if rock == 'O':
                new_idx = idx - 1
                while new_idx > -1 and platform[new_idx][jdx] == '.' :
                    new_idx -= 1
                platform[idx][jdx] = '.'
                platform[new_idx+1][jdx] = 'O'

    if south:
        platform.reverse()


def roll_we(platform, east):
    if east:
        for line in platform:
            line.reverse()

    for idx, line in enumerate(platform):
        for jdx, rock in enumerate(line):
            if rock == 'O':
                new_jdx = jdx - 1
                while new_jdx > -1 and platform[idx][new_jdx] == '.':
                    new_jdx -= 1
                platform[idx][jdx] = '.'
                platform[idx][new_jdx+1] = 'O'

    if east:
        for line in platform:
            line.reverse()

def roll_east(platform):
    for idx, line in enumerate(platform):
        for jdx, rock in enumerate(line):
            if rock == 'O':
                new_jdx = jdx + 1
                while new_jdx < len(platform[0]) and platform[idx][new_jdx] == '.':
                    new_jdx += 1
                platform[idx][jdx] = '.'
                platform[idx][new_jdx-1] = 'O'


def part1():
    print("Advent of Code 2023: Day 14.1")

    sum = 0
    with open("day14.in", 'r') as file:
        platform = [list(x) for x in [line.strip() for line in file.readlines()]] 

        # Roll north
        roll_ns(platform, False)

        for idx, line in enumerate(platform):
           sum += line.count('O') * (len(platform) - idx)

    print("The sum is", sum)
        

def part2():
    print("Advent of Code 2023: Day 14.2")

    sum = 0
    with open("day14_test.in", 'r') as file:
        platform = [list(x) for x in [line.strip() for line in file.readlines()]]

        for idx in range(1000000000):
            roll_ns(platform, False)
            roll_we(platform, False)
            roll_ns(platform, True)
            roll_we(platform, True)


        for idx, line in enumerate(platform):
           sum += line.count('O') * (len(platform) - idx)

    print("The sum is", sum)

if __name__ == "__main__":
    part1()
    print()
    part2()
