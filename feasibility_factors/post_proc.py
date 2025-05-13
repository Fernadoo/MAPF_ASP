invalid = [(4,3), (4,2), (1,3)]
invalid_comb = [[(3,3), (4,2)], [(2,2), (2,3)], [(2,2), (3,3)], [(2,3), (3,2)], [(3,2), (4,3)],
                [(3,2), (4,2)], [(1,2), (2,3)], [(1,2), (2,2)], [(1,3), (2,2)], [(1,3), (2,3)],
                [(3,3), (4,3)], [(1,2), (2,1)], [(1,1), (2,2)]]
test_file = 'feasibility_factors/m4_d19_sd3/s2.txt'

with open(test_file, 'r') as f:
    line = f.readline()
    cnt = 0
    unsat = 0
    while line:
        invalid_goal = False
        goals, sat = line.split('\t\t ')
        goals = eval(goals.split(':')[1])
        for goal in goals:
            if goal in invalid:
                cnt += 1
                invalid_goal = True
                break
        for comb in invalid_comb:
            if set(comb).issubset(set(goals)) and not invalid_goal:
                cnt += 1
                invalid_goal = True
                break

        if 'UNSAT' in sat:
            unsat += 1
        if 'UNSAT' in sat and not invalid_goal:
            print(line)
        line = f.readline()
print(cnt, unsat)
