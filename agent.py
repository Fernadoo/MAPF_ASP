import numpy as np

class Agent():

    def __init__(self, name, policy, sensor, layout):
        self.name = name
        self.policy = policy
        self.R = len(sensor) // 2
        self.layout = layout

    def observe(self, game_state):
        me, other, obs = None, None, None
        for name in game_state['POSITIONS']:
            if name == self.name:
                me = game_state['POSITIONS'][name]
            else:
                other = game_state['POSITIONS'][name]
        if abs(other[0] - me[0]) <= self.R and abs(other[1] - me[1]) <= self.R:
            obs = other
        else:
            obs = None
        return (me, obs)

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
        if succ[0] not in range(len(self.layout)) or \
                succ[1] not in range(len(self.layout[0])) or \
                self.layout[succ] == 1:
            raise ValueError('Illegal action!')
        return succ

    def get_action(self, agent_state):
        action = self.policy[str(agent_state)]
        return action
