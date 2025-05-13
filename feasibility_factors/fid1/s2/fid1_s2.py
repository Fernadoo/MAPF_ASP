import os
from itertools import product
from tqdm import tqdm
import numpy as np


def parse_map_from_file(map_name):
    layout = []
    with open(map_name, 'r') as f:
        line = f.readline()
        while line:
            if line.startswith('#'):
                pass
            else:
                row = []
                for char in line:
                    if char == '.':
                        row.append(0)
                    elif char == '@':
                        row.append(1)
                    else:
                        continue
                layout.append(row)
            line = f.readline()
    return np.array(layout)


layout = parse_map_from_file('../fid1.map')
print(layout)
basename = os.path.basename(__file__).split('.')[0]
log_file = open(f'{basename}.txt', 'w')
for (i1, i2, j1, j2) in tqdm(product(range(1, 4), repeat=4)):
    if (i1, j1) == (i2, j2) \
            or layout[(i1, j1)] == 1 \
            or layout[(i2, j2)] == 1:
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
    # if j1 == 2:
    #     break
log_file.close()
