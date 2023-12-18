def part1():
    print("Advent of Code 2023: Day 17.1")

    with open("day17_test.in", 'r') as file:
        grid = [list(map(int, x.strip())) for x in file.readlines()]

        index = lambda pair: pair[0] * len(grid) + pair[1]

        # Build weight matrix 
        m_len = len(grid)**2
        w = [[10000000 for x in range(m_len)] for line in range(m_len)]
        for idx, _ in enumerate(grid):
            for jdx, _ in enumerate(grid):
                w[idx][idx] = 0
                if idx > 0:
                    w[index((idx, jdx))][index((idx-1, jdx))] = grid[idx-1][jdx]
                if idx < len(grid)-1:
                    w[index((idx, jdx))][index((idx+1, jdx))] = grid[idx+1][jdx]
                if jdx > 0:
                    w[index((idx, jdx))][index((idx, jdx-1))] = grid[idx][jdx-1]
                if jdx < len(grid)-1:
                    w[index((idx, jdx))][index((idx, jdx+1))] = grid[idx][jdx+1]

        # Floyd_Warshall alg
        d_last = w
        for kdx in range(0, m_len):
            d = [[10000000 for x in range(m_len)] for line in range(m_len)]
            for idx in range(0, m_len):
                for jdx in range(0, m_len):
                    d[idx][jdx] = min(d_last[idx][jdx],\
                                      d_last[idx][kdx] + d_last[kdx][jdx])
            d_last = d

        # Get the dist((0, 0) to (len(grid)-1, len(grid)-1))
        print("The least amount of heat loss is", d[0][m_len-1])


def part2():
    print("Advent of Code 2023: Day 17.2")


if __name__ == "__main__":
    part1()
    print()
    part2()
