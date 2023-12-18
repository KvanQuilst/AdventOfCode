def part1():
    print("Advent of Code 2023, Day 18.1")

    area = 0
    with open("day18_test.in", 'r') as file:
        lines = file.readlines()

        #         v- v+ h- h+
        ranges = [0, 1, 0, 1]
        pos = [0, 0]
        for line in lines:
            dir, dist, col = line.strip().split()
            dist = int(dist)
            
            match dir:
                case 'U':
                    pos[0] -= dist
                    if pos[0] < ranges[0]:
                        ranges[0] = pos[0]

                case 'D':
                    pos[0] += dist
                    if pos[0] >= ranges[1]:
                        ranges[1] = pos[0] + 1

                case 'L':
                    pos[1] -= dist
                    if pos[1] < ranges[2]:
                        ranges[2] = pos[1]

                case 'R':
                    pos[1] += dist
                    if pos[1] >= ranges[3]:
                        ranges[3] = pos[1] + 1

        grid = [['.' for x in range(ranges[2], ranges[3])]\
                 for line in range(ranges[0], ranges[1])]
        pos = [0 - ranges[0] if ranges[0] < 0 else 0,\
               0 - ranges[2] if ranges[2] < 0 else 0]
        grid[pos[0]][pos[1]] = '$'
        for line in lines:
            dir, dist, col = line.strip().split()
            dist = int(dist)
            area += dist

            match dir:
                case 'U':
                    for l in grid[pos[0]-dist+1:pos[0]]:
                        l[pos[1]] = '#'
                    pos[0] -= dist

                case 'D':
                    pos[0] += dist
                    for l in grid[pos[0]-dist+1:pos[0]+1]:
                        l[pos[1]] = '#'

                case 'L':
                    grid[pos[0]][pos[1]-dist+1:pos[1]] = ['#' for x in range(dist-1)]
                    pos[1] -= dist

                case 'R':
                    pos[1] += dist
                    grid[pos[0]][pos[1]-dist+1:pos[1]] = ['#' for x in range(dist-1)]
            grid[pos[0]][pos[1]] = '$'

        # Shoelace Formula
        verts = []
        for idx, line in enumerate(grid):
            for jdx, m in enumerate(line):
                if m == '$':
                    verts.append((idx, jdx))

        sub_area = 0
        print(verts)
        for idx, _ in enumerate(verts[1:-1], 1):
            sub_area += verts[idx][0] * (verts[idx+1][1] - verts[idx-1][1])
        sub_area += verts[0][0] * (verts[1][1] - verts[-1][1])
        sub_area += verts[-1][0] * (verts[0][1] - verts[-2][1])

        print(int(sub_area))
        area += sub_area

        #ln = max(len(grid), len(grid[0]))
        #for end in range(1, ln):
        #    state = 0
        #    count = 0
        #    for idx in range(0, end):
        #        if end-idx-1 == len(grid) or idx == len(grid[0]):
        #            break
        #        #print(end-idx-1, idx)
        #        m = grid[end-idx-1][idx]

        #        if state == 0 and m == '#':
        #            state = 1
        #        elif state == 1 and m == '.':
        #            state = 2
        #            count += 1
        #            grid[end-idx-1][idx] = '#'
        #        elif state == 2 and m == '.':
        #            count += 1
        #            grid[end-idx-1][idx] = '#'
        #        elif state == 2 and m == '#':
        #            state = 3
        #            #line[idx-count:idx] = ['#' for x in range(count)]
        #            area += count
        #            count = 0
        #        elif state == 3 and m == '.':
        #            state = 0

        #for l in grid:
        #    print(''.join(l))

    print("The total area is", int(area))


def part2():
    print("Advent of Code 2023, Day 18.2")


if __name__ == "__main__":
    part1()
    print()
    part2()
