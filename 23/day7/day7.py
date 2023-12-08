def part1():
    print("Advent of Code 2023, Day 7.1")

    cards = ['2','3','4','5','6','7','8','9','T','J','Q','K','A']

    sum = 0
    with open("day7.in", 'r') as file:
        lines = file.readlines()

        hands = [[x[0], int(x[1]), 0] for x in [line.split() for line in lines]]

        ranks = []
        for hand, bid, strength in hands:
            # 0x6xxxxx - 5 of a kind
            # 0x5xxxxx - 4 of a kind
            # 0x4xxxxx - Full house
            # 0x3xxxxx - 3 of a kind
            # 0x2xxxxx - 2 pair
            # 0x1xxxxx - 1 pair
            # 0x0xxxxx - High card
            # x - [2, A] -> [0, 12]

            cnt = [0 for x in range(13)]
            for idx, card in enumerate(hand, 1):
                cnt[cards.index(card)] += 1
                strength += cards.index(card) * 0x10**(5-idx) 

            if 5 in cnt:
                strength += 0x600000
            elif 4 in cnt:
                strength += 0x500000
            elif 3 in cnt and 2 in cnt:
                strength += 0x400000
            elif 3 in cnt:
                strength += 0x300000
            elif cnt.count(2) == 2:
                strength += 0x200000
            elif 2 in cnt:
                strength += 0x100000
    
            ranks.append((strength, bid))
                            
        ranks.sort(key=lambda x: x[0])
        for idx, bid in enumerate(ranks, 1):
            sum += bid[1] * idx

    print("The sum is", sum)

def part2():
    print("Advent of Code 2023, Day 7.2")

    cards = ['J','2','3','4','5','6','7','8','9','T','Q','K','A']

    sum = 0
    with open("day7.in", 'r') as file:
        lines = file.readlines()

        hands = [[x[0], int(x[1]), 0] for x in [line.split() for line in lines]]

        ranks = []
        for hand, bid, strength in hands:
            # 0x6xxxxx - 5 of a kind
            # 0x5xxxxx - 4 of a kind
            # 0x4xxxxx - Full house
            # 0x3xxxxx - 3 of a kind
            # 0x2xxxxx - 2 pair
            # 0x1xxxxx - 1 pair
            # 0x0xxxxx - High card
            # x - [J, A] -> [0, 12]

            cnt = [0 for x in range(13)]
            for idx, card in enumerate(hand, 1):
                cnt[cards.index(card)] += 1
                strength += cards.index(card) * 0x10**(5-idx) 
            
            j_cnt = [x + cnt[0] for x in cnt[1:]]

            if 5 in j_cnt:
                strength += 0x600000
            elif 4 in j_cnt:
                strength += 0x500000
            elif 3 in cnt and 2 in cnt\
              or 3 in cnt and cnt[0] == 1\
              or cnt[0] == 2 and 2 in cnt[1:]\
              or cnt[1:].count(2) and cnt[0] == 1:
                strength += 0x400000
            elif 3 in j_cnt:
                strength += 0x300000
            elif cnt.count(2) == 2:
                strength += 0x200000
            elif 2 in j_cnt:
                strength += 0x100000
    
            ranks.append((strength, bid))
                            
        ranks.sort(key=lambda x: x[0])
        for idx, bid in enumerate(ranks, 1):
            sum += bid[1] * idx

    print("The sum is", sum)

if __name__== "__main__":
    part1()
    print()
    part2()
