from search import AStar

import numpy as np


class Agent():

    def __init__(self, name, policy, sensor, layout):
        self.name = name
        self.policy = policy
        self.R = len(sensor) // 2
        self.layout = layout

    def register(self, start, goal):
        self.goal = goal
        self.searcher = AStar(start, goal, self.layout)
        self.plan = self.seacher.planning(start)

    def observe(self, game_state):
        me, others = game_state['POSITIONS'][self.name], []
        for name in game_state['POSITIONS']:
            if name == self.name:
                continue
            else:
                a = game_state['POSITIONS'][name]
                # print(a, me)
                if abs(a[0] - me[0]) <= self.R and abs(a[1] - me[1]) <= self.R:
                    others.append(a)
                else:
                    others.append(None)
        return tuple([me] + others)

    def move(self, curr, A):
        action_dict = {
            'nil': [0, 0],
            'up': [-1, 0],
            'down': [1, 0],
            'left': [0, -1],
            'right': [0, 1],
        }
        succ = tuple(np.add(curr, action_dict[A]))
        if succ[0] not in range(len(self.layout)) or \
                succ[1] not in range(len(self.layout[0])) or \
                self.layout[succ] == 1:
            raise ValueError('Illegal action!')
        return succ

    def get_action(self, agent_state):
        action = self.policy[str(agent_state)]
        return action
