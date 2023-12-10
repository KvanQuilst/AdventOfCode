def next(field, curr, prev):
    north = ('|','7','F')
    south = ('|','L','J')
    east  = ('-','J','7')
    west  = ('-','L','F')

    typ = field[curr[0]][curr[1]]
    match typ:
        case '|':
            if prev[0] < curr[0]:
                return (curr[0]+1, curr[1])
            else:
                return (curr[0]-1, curr[1])

        case '-':
            if prev[1] < curr[1]:
                return (curr[0], curr[1]+1)
            else:
                return (curr[0], curr[1]-1)

        case 'L':
            if prev[0] < curr[0]: # if prev above
                return (curr[0], curr[1]+1)
            else:
                return (curr[0]-1, curr[1])

        case 'J':
            if prev[0] < curr[0]: # if prev above
                return (curr[0], curr[1]-1)
            else:
                return (curr[0]-1, curr[1])

        case '7':
            if prev[0] > curr[0]: # if prev below
                return (curr[0], curr[1]-1)
            else:
                return (curr[0]+1, curr[1])

        case 'F':
            if prev[0] > curr[0]: # if prev below
                return (curr[0], curr[1]+1)
            else:
                return (curr[0]+1, curr[1])

        case 'S':
            if curr[0] != 0 and field[curr[0]-1][curr[1]] in north:
                return (curr[0]-1, curr[1])
            elif curr[0] != len(field)-1 and field[curr[0]+1][curr[1]] in south:
                return (curr[0]+1, curr[1])
            elif curr[1] != 0 and field[curr[0]][curr[1]-1] in west:
                return (curr[0], curr[1]-1)
            elif curr[1] != len(field[0])-1 and field[curr[0]][curr[1]+1] in east:
                return (curr[0], curr[1]+1)
            else:
                return curr


def part12():
    print("Advent of Code 2023, Day 10.1")

    with open("day10.in", 'r') as file:
        field = file.readlines()
        grid = [['.' for x in field[0]] for y in field]

        start = ()
        for idx, line in enumerate(field):
            if 'S' in line:
                start = (idx, line.index('S'))

        curr = start
        prev = curr
        curr = next(field, curr, ())
        grid[prev[0]][prev[1]] = 'o'
        dist = 1
        
        while curr != start:
            grid[curr[0]][curr[1]] = 'o'
            n = next(field, curr, prev)
            prev = curr
            curr = n
            dist += 1

        print("The max dist from S is:", int (dist / 2))

        print()
        print("Advent of Code 2023: Day 10.2")

        area = 0


        print("The area in the loop is... count it yourself:")
        for line in grid:
            print(''.join(line))
        

if __name__ == "__main__":
    part12()
