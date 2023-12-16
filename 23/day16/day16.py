

def part1():
    print("Advent of Code 2023, Day 12.1")

    count = 0
    with open("day16.in", 'r') as file:
        grid = [list(line.strip()) for line in file.readlines()]

        e = [[False for x in grid[0]] for line in grid]


        beams = [((0, 0), (0, 1))]
        def trace(pos, dir):
            # dir - (v, h)
            count_e = 0
            
            while True:
                x, y = pos
                if x < 0 or y < 0 or x >= len(grid) or y >= len(grid[0]):
                    return
    
                if e[x][y]:
                    count_e += 1
                else:
                    e[x][y] = True
                    count_e = 0

                if count_e > 100:
                    return
                
                match grid[x][y]:
                    case '|':
                        if dir[1] != 0:
                            dir = (1, 0)
                            beams.append(((x - 1, y), (-1, 0)))

                    case '-':
                        if dir[0] != 0:
                            dir = (0, 1)
                            beams.append(((x, y - 1), (0, -1)))

                    case '\\':
                        dir = (dir[1], dir[0])

                    case '/':
                        dir = (0 - dir[1], 0 - dir[0])

                pos = (x + dir[0], y + dir[1])

        prev_count = 0
        same_count = 0
        while beams:
            trace(beams[0][0], beams.pop(0)[1])
            count = [x for line in e for x in line].count(True)
            if prev_count == count:
                same_count += 1
            else:
                same_count = 0
                prev_count = count
            if same_count > 50000:
                break

    print("The count of energized cells is", count)


def part2():
    print("Advent of Code 2023, Day 12.2")

    max_count = 0
    with open("day16.in", 'r') as file:
        grid = [list(line.strip()) for line in file.readlines()]



        starts = [((0, y), (1, 0)) for y, _ in enumerate(grid[0])]
        starts += [((len(grid[0])-1, y), (-1, 0)) for y, _ in enumerate(grid[0])]
        starts += [((x, 0), (0, 1)) for x, _ in enumerate(grid)]
        starts += [((x, len(grid)-1), (0, -1)) for x, _ in enumerate(grid)]

        for start in starts:
            beams = [(start[0], start[1])]
            e = [[False for x in grid[0]] for line in grid]

            def trace(pos, dir):
                # dir - (v, h)
                count_e = 0
                
                while True:
                    x, y = pos
                    if x < 0 or y < 0 or x >= len(grid) or y >= len(grid[0]):
                        return
        
                    if e[x][y]:
                        count_e += 1
                    else:
                        e[x][y] = True
                        count_e = 0

                    if count_e > 100:
                        return
                    
                    match grid[x][y]:
                        case '|':
                            if dir[1] != 0:
                                dir = (1, 0)
                                beams.append(((x - 1, y), (-1, 0)))

                        case '-':
                            if dir[0] != 0:
                                dir = (0, 1)
                                beams.append(((x, y - 1), (0, -1)))

                        case '\\':
                            dir = (dir[1], dir[0])

                        case '/':
                            dir = (0 - dir[1], 0 - dir[0])

                    pos = (x + dir[0], y + dir[1])

            count = 0
            prev_count = 0
            same_count = 0
            while beams:
                trace(beams[0][0], beams.pop(0)[1])
                count = [x for line in e for x in line].count(True)
                if prev_count == count:
                    same_count += 1
                else:
                    same_count = 0
                    prev_count = count
                if same_count > 50000:
                    break
            max_count = max(max_count, count)

    print("The maximum energized count is", max_count)

if __name__ == "__main__":
    #part1()
    #print()
    part2()
