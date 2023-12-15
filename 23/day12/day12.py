def part1():
    print("Advent of Code 2023, Day 12.1")
    
    with open("day12_test.in", 'r') as file:
        lines = file.readlines()

        for line in lines:
            springs, arr = line.split()
            arr = [int(x) for x in arr.split(',')]

            # first pass: solid candidates (no ?'s surrounding)
            valid = True
            counting = False
            count = 0

            rm = []
            for s in springs:
                if valid:
                    if s == '?':
                        valid = False
                        counting = False
                        count = 0
                    elif s == '#':
                        counting = True
                        count += 1
                    elif counting and s == '.':
                        rm.append(arr.pop(arr.index(count)))
                        counting = False
                        count = 0

                else:
                    if s == '.':
                        valid = True

            if counting:
                rm.append(arr.pop(arr.index(count)))

            for item in rm:
                springs = springs.replace('#' * item, '')
                    
            print(springs, arr) 



def part2():
    print("Advent of Code 2023, Day 12.2")


if __name__ == "__main__":
    part1()
    print()
    part2()
