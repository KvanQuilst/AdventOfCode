def part1():
    print("Advent of Code 2023: Day 11.1")

    sum = 0
    with open("day11.in", 'r') as file:
        universe = [list(x.strip()) for x in file.readlines()]
        
        # Expand universe
        lines = []
        for idx, line in enumerate(universe):
            if all([x == '.' for x in line]):
                lines.append(idx)

        count = 0
        for line in lines:
            universe.insert(line + count, ['.' for x in universe[0]])
            count += 1

        cols = []
        for idx in range(len(universe[0])):
            if all([x[idx] == '.' for x in universe]):
                cols.append(idx)

        count = 0
        for col in cols:
            for line in universe:
                line.insert(col + count, '.')
            count += 1

        # Enumerate Galaxies
        galaxies = []
        for idx, line in enumerate(universe):
            for jdx, c in enumerate(line):
                if c == '#':
                    galaxies.append((idx, jdx))

        for idx, g1 in enumerate(galaxies[:-1]):
            for g2 in galaxies[idx+1:]:
                sum += abs(g1[0] - g2[0]) + abs(g1[1] - g2[1])

    print("The sum is", sum)


def part2():
    print("Advent of Code 2023: Day 11.2")

    sum = 0
    with open("day11_test.in", 'r') as file:
        universe = [list(x.strip()) for x in file.readlines()]
        
        # Expand universe
        cols = []
        for idx in range(len(universe[0])):
            if all([x[idx] == '.' for x in universe]):
                cols.append(idx)

        count = 0
        for col in cols:
            for i in range(1000000):
                for line in universe:
                    line.insert(col + count, '.')
                count += 1

        lines = []
        for idx, line in enumerate(universe):
            if all([x == '.' for x in line]):
                lines.append(idx)

        count = 0
        for line in lines:
            for i in range(1000000):
                universe.insert(line + count, ['.' for x in universe[0]])
                count += 1

        # Enumerate Galaxies
        galaxies = []
        for idx, line in enumerate(universe):
            for jdx, c in enumerate(line):
                if c == '#':
                    galaxies.append((idx, jdx))

        for idx, g1 in enumerate(galaxies[:-1]):
            for g2 in galaxies[idx+1:]:
                sum += abs(g1[0] - g2[0]) + abs(g1[1] - g2[1])

    print("The sum is", sum)


if __name__ == "__main__":
    part1()
    print()
    part2()
