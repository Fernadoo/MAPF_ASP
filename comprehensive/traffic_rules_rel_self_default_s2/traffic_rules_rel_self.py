import os
from itertools import product
from tqdm import tqdm

basename = os.path.basename(__file__).split('.')[0]
log_file = open(f'{basename}.log', 'w')
for (i1, i2, j1, j2) in tqdm(product(range(1, 7), repeat=4)):
    if (i1, j1) == (i2, j2):
        continue
    # print((i1, i2, j1, j2))
    test_file_name = f'{basename}_tmp/{i1}-{j1}_{i2}-{j2}.lp'
    test_file = open(test_file_name, 'w')
    test_file.write(f'goal1(G) :- G = ({i1}, {j1}).\n'
                    f'goal2(G) :- G = ({i2}, {j2}).')
    with open('tmplt.lp') as tmplt:
        test_file.write(tmplt.read())
    test_file.close()
    os.system(f'clingo {test_file_name}> tmp.sol')

    with open('tmp.sol') as sol:
        line = sol.readline()
        while line:
            # print(line)
            if line.startswith('Answer'):
                log_file.write(f'Goals: {(i1, j1), (i2, j2)}\t\t SAT\n')
                break
            elif line.startswith('UNSATISFIABLE'):
                log_file.write(f'Goals: {(i1, j1), (i2, j2)}\t\t UNSAT\n')
                break
            line = sol.readline()
    # if j2 == 3:
    #     break
log_file.close()
