import os
from itertools import product
from tqdm import tqdm
import numpy as np
import random
from copy import deepcopy


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


# for square maps
def generate_rand_map(layout, density, seed):
    new_layout = deepcopy(layout)
    size = len(layout) - 2  # exclude walls
    num_obs = int(size ** 2 * (density / 100))
    random.seed(seed)

    obs = random.sample(list(product(range(1, size + 1), repeat=2)), num_obs)
    print(obs)
    for x, y in obs:
        new_layout[x, y] = 1
    new_map_dir = f'./feasibility_factors/m{size}_d{density}_sd{seed}'
    if not os.path.exists(new_map_dir):
        os.mkdir(new_map_dir)
    new_map_file = open(f'{new_map_dir}/m{size}_d{density}_sd{seed}.map', 'w')
    for i in range(len(new_layout)):
        for j in range(len(new_layout[0])):
            if new_layout[i, j] == 1:
                new_map_file.write('@')
            else:
                new_map_file.write('.')
        new_map_file.write('\n')
    new_map_file.close()
    os.system(f'cp {new_map_dir}/m{size}_d{density}_sd{seed}.map ./configs/maps/')
    return new_layout, f'm{size}_d{density}_sd{seed}'


# Need to manually check the map, see if any corner cases 

# layout = parse_map_from_file('./configs/maps/5by5.map')
# print(layout)

# for density, seed, in product([10, 20, 30], [1, 2, 3]):
#     rand_layout, rand_layout_name = generate_rand_map(layout, density, seed)
#     print(rand_layout)


# layout = parse_map_from_file('./configs/maps/4by4.map')
# print(layout)

# for density, seed, in product([7, 13, 19], [1, 2, 3]):
#     rand_layout, rand_layout_name = generate_rand_map(layout, density, seed)
#     print(rand_layout)
