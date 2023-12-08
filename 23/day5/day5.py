def part1():
    print("Advent of Code 2023, Day 5.1")

    with open("day5.in", 'r') as file:
        lines = file.readlines()

        seeds = [int(s) for s in lines[0].split(":")[1].split()]
        m = [[x, x, x, x, x, x, x, x] for x in seeds]

        l = 3
        for i in range(1, 8):
            r_vals = []
            while l < len(lines) and not lines[l].isspace():
                r_vals.append([int(s) for s in lines[l].split()])
                l += 1

            for s in m:
                for r_val in r_vals:
                    if s[i] in range(r_val[1], r_val[1] + r_val[2]):
                        s[i:] = [r_val[0] + (s[i] - r_val[1]) for x in range(i, 8)]
                        break
            l += 2

        minimum = min([x[7] for x in m])

        print("The minimum locality value is", minimum)


def part2():
    print("Advent of Code 2023, Day 5.2")

    with open("day5.in", 'r') as file:
        lines = file.readlines()

        seed_ranges = [int(s) for s in lines[0].split(":")[1].split()]
        seed_ranges = [(seed_ranges[x], seed_ranges[x+1]) for x in range(0, len(seed_ranges), 2)]
        minimum = -1
        
        for seeds in seed_ranges:
            m = [x for x in range(seeds[0], seeds[0]+seeds[1])]

            l = 3
            for i in range(1, 8):
                r_vals = []
                while l < len(lines) and not lines[l].isspace():
                    r_vals.append([int(s) for s in lines[l].split()])
                    l += 1

                for s in m:
                    for r_val in r_vals:
                        if s in range(r_val[1], r_val[1] + r_val[2]):
                            s = r_val[0] + (s - r_val[1])
                            break
                l += 2

            if minimum == -1:
                minimum = min(m)
            else:
                minimum = min(min(m), minimum)

        print("The minimum locality value is", minimum)

if __name__ == "__main__":
    part1()
    print()
    part2()
