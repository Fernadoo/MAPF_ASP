import numpy as np

class Agent():

    def __init__(self, name, policy, sensor=None):
        self.name = name
        self.policy = policy
        self.sensor = sensor

    def observe(self, game_state):
        me, other = game_state[:2]
        if abs(other[0] - me[0]) <= 1 and abs(other[1] - me[1]) <= 1:
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
        if succ[0] not in range(3) or \
                succ[1] not in range(3) or \
                succ == (1, 1):
            raise ValueError('Illegal action!')
        return succ

    def get_action(self, agent_state):
        action = self.policy[str(agent_state)]
        return action
