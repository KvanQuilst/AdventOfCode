def part1():
    print("Advent of Code 2023, Day 20.1")

    hi_count = 0
    lo_count = 0
    with open("day20_test.in", 'r') as file:
        lines = file.readlines()

        modules = {l[0][1:] if l[0][0] in '%&' else l[0] : (l[0][0], l[1].split(', ')) for l in 
                   [line.strip().split(' -> ') for line in lines]}
        flip = {}
        con = {}

        # 0 = low, 1 = high
        for _ in range(1000):
            queue = [('broadcaster', 0, 'button')]
            lo_count += 1
            while queue:
                n = queue.pop(0)
                if not n[0] in modules:
                    continue

                module = modules[n[0]]

                if module[0] == '%':
                    if n[1] == 0:
                        out = 0
                        if n[0] in flip and flip[n[0]]:
                            out = 0
                            flip[n[0]] = False
                        else:
                            out = 1
                            flip[n[0]] = True
                        for mod in module[1]:
                            if out == 1:
                                hi_count += 1
                            else:
                                lo_count += 1
                            queue.append((mod, out, n[0]))

                elif module[0] == '&':
                    if not n[0] in con:
                        con[n[0]] = {}
                    con[n[0]][n[2]] = n[1]
                    out = 0
                    if all([v == 1 for v in con[n[0]].values()]):
                        out = 0
                    else:
                        out = 1
                    for mod in module[1]:
                        if out == 1:
                            hi_count += 1
                        else:
                            lo_count += 1
                        queue.append((mod, out, n[0]))

                else:
                    for mod in module[1]:
                        if n[1] == 1:
                            hi_count += 1
                        else:
                            lo_count += 1
                        queue.append((mod, 0, n[0]))

    print("The counts are:", hi_count, lo_count)

def part2():
    print("Advent of Code 2023, Day 20.2")


if __name__ == "__main__":
    part1()
    print()
    part2()
