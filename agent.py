from search import AStar

from queue import Queue

import numpy as np

# possible statuses
IDLE = 0
ENGAGED = 1


class Agent():

    def __init__(self, name, policy, sensor, layout):
        self.name = name
        self.policy = policy
        self.R = len(sensor) // 2
        self.layout = layout
        self.status = IDLE

    def register(self, start, goal):
        self.goal = goal
        self.searcher = AStar(goal, self.layout)
        self.curr = self.start
        self.plan = self.seacher.planning(self.curr)

    def update_layout(self, mask):
        self.layout = np.array(np.logical_or(self.layout, mask),
                               dtype=int)
        self.searcher.update_layout(self.layout)
        self.plan = self.seacher.planning(self.curr)

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

        # build communication network
        self.net = others
        return tuple([me] + others)

    def build_closure(self, game_state):
        """
        return a dict of {agent_name: (ture_pos, ture_goal)}
        """
        if getattr(self, 'net', None) is None:
            raise ValueError('Let the agent observe first!')

        global_agents = game_state['AGENTS']

        closure = dict()
        visited = []
        Q = Queue()
        for name in self.net:
            Q.put(name)

        while not Q.empty():
            name = Q.get()
            while name in visited:
                name = Q.get()
            succ_agent = global_agents[name]
            closure[name] = (succ_agent.curr,
                             succ_agent.goal,
                             succ_agent.status)
            for child in succ_agent.net:  # .net might not exist
                Q.put(child)

        self.closure = closure
        return closure

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
        # update current location
        self.curr = agent_state[0]

        # 1. no agent detected, follow default plan
        if len(agent_state) == 1:
            return self.plan.pop()

        # 2. if any agent found, coordinate by certain local policy
        if getattr(self, 'closure', None) is None:
            raise ValueError('Get transitive closure for the agent first!')

        self.status = ENGAGED
        # TODO
        policy_type = self.get_policy_type_from_closure()
        action = self.policy[str(agent_state)]
        return action

    def get_policy_type_from_closure(self):
        """TODO
        policy_type = [
            '2_by_2_2a_side',
            '2_by_2_2a_diagonal',
            '3_by_3_3a_side',
            '3_by_3_3a_diagonal',
            '3_by_3_4a_full',
        ]
        """
        pass
