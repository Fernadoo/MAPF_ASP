from matplotlib import pyplot as plt
from matplotlib import colors
import os
import numpy as np


def parse_map_from_file(map_config):
    PREFIX = 'configs/maps/'
    POSTFIX = '.map'
    if not os.path.exists(PREFIX + map_config + POSTFIX):
        raise ValueError('Map config does not exist!')
    layout = []
    with open(PREFIX + map_config + POSTFIX, 'r') as f:
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


goals = {
    'test': [(1, 1), (2, 1), (3, 1)],
}


map_file, num = 'test', 3
data = parse_map_from_file(map_file)
print(len(data), len(data[0]))

cmap = list(colors.CSS4_COLORS)[:num]
plt.figure(figsize=(15, 15))
plt.pcolor(data, cmap=cmap, edgecolors='k', linewidths=0.1)
# plt.gca().invert_xaxis()
plt.gca().invert_yaxis()
plt.savefig(f'/Users/fernando/Desktop/{map_file}_{num}.png')
plt.show()
