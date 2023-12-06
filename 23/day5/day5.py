def part1():
    print("Advent of Code 2023, Day 5.1")

    with open("day5.in", 'r') as file:
        lines = file.readlines()

        seeds = [int(s) for s in lines[0].split(":")[1].split()]
        m = [[x, x, x, x, x, x, x, x] for x in seeds]

        l = 3
        for i in range(1, 8):
            f = []
            t = []
            while l < len(lines) and not lines[l].isspace():
                r_val = [int(s) for s in lines[l].split()]
                f += [x for x in range(r_val[1], r_val[1] + r_val[2])]
                t += [x for x in range(r_val[0], r_val[0] + r_val[2])]
                l += 1

            for s in m:
                if s[i] in f:
                    s[i:] = [t[f.index(s[i])] for x in range(i,8)]
                
            l += 2

        minimum = min([x[7] for x in m])

        print("The minimum locality value is", minimum)


def part2():
    print("Advent of Code 2023, Day 5.2")


if __name__ == "__main__":
    part1()
    print()
    part2()
