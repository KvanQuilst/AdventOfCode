def part1():
    print("Advent of Code 2023, Day 19.1")

    sum = 0
    with open("day19.in", 'r') as file:
        lines = file.readlines()

        sep = lines.index('\n')
        rules = {r[0] : r[1].rstrip('}\n').split(',') for r in\
                    [rule.split('{') for rule in lines[0:sep]]}
        parts = [(int(p[0][2:]), int(p[1][2:]), int(p[2][2:]), int(p[3][2:])) for p in\
                    [part.strip('{}\n').split(',') for part in lines[sep+1:]]]

        for x, m, a, s in parts:
            wf = 'in'

            while wf != 'A' and wf != 'R':
                rs = rules[wf]
                for r in rs:
                    if not ':' in r:
                        wf = r
                        break

                    r, dst = r.split(':')
                    if r[1] == '<' and eval(r[0]) < int(r[2:]):
                        wf = dst
                        break
                    elif r[1] == '>' and eval(r[0]) > int(r[2:]):
                        wf = dst 
                        break

            if wf == 'A':
                sum += x + m + a + s

    print("The sum is", sum)


def part2():
    print("Advent of Code 2023, Day 19.2")

    count = 0
    with open("day19_test.in", 'r') as file:
        lines = file.readlines()

        sep = lines.index('\n')
        workflows = {r[0] : r[1].rstrip('}\n').split(',') for r in\
                        [rule.split('{') for rule in lines[0:sep]]}

        A_ranges = []

        def rule_range(wf, x, m, a, s):
            if wf == 'A':
                A_ranges.append((x, m , a, s))
                return
            elif wf == 'R':
                return

            rules = workflows[wf]
            for rule in rules:
                if not ':' in rule:
                    rule_range(rule, x, m, a, s)
                    return

                r, dst = rule.split(':')
                val = int(r[2:])
                if r[1] == '<':
                    if val > eval(r[0])[1]:
                        rule_range(dst, x, m, a, s)
                    else:
                        match r[0]:
                            case 'x':
                                rule_range(dst, [x[0], val], m, a, s)
                            case 'm':
                                rule_range(dst, x, [m[0], val], a, s)
                            case 'a':
                                rule_range(dst, x, m, [a[0], val], s)
                            case 's':
                                rule_range(dst, x, m, a, [s[0], val])
                else:
                    if val < eval(r[0])[0]:
                        rule_range(workflows[dst], x, m, a, s)
                    else:
                        match r[0]:
                            case 'x':
                                rule_range(dst, [val+1, x[1]], m, a, s)
                            case 'm':
                                rule_range(dst, x, [val+1, m[1]], a, s)
                            case 'a':
                                rule_range(dst, x, m, [val+1, a[1]], s)
                            case 's':
                                rule_range(dst, x, m, a, [val+1, a[1]])


        rule_range('in', [1, 4001], [1, 4001], [1, 4001], [1, 4001])

        for idx, r in enumerate(A_ranges):
            A_ranges[idx] = []
            for v in r:
                A_ranges[idx].append(range(v[0], v[1]))
            print(A_ranges[idx])

    print("The number of combinations is", count)


if __name__ == "__main__":
    part1()
    print()
    part2()
