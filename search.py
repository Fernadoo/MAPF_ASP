from queue import PriorityQueue

import numpy as np

action_dict = {
    'nil': [0, 0],
    'up': [-1, 0],
    'down': [1, 0],
    'left': [0, -1],
    'right': [0, 1],
}


class AStar():
    """docstring for AStar"""

    def __init__(self, start, goal, layout):
        self.start = start
        self.goal = goal
        self.layout = layout

    def get_successors(self, curr):
        successors = []
        for a in action_dict:
            succ = tuple(np.add(curr, action_dict[a]))
            if succ[0] not in range(len(self.layout)) or \
                    succ[1] not in range(len(self.layout[0])) or \
                    self.layout[succ] == 1:
                continue
            successors.append((succ, a))
        return successors

    def heuristic(self, pos):
        return np.linalg.norm(np.subtract(pos, self.goal),
                              ord=2)

    def planning(self, curr):
        visited = []
        parent_dict = dict()
        expand = None

        Q = PriorityQueue()
        Q.put((0, 0, curr, None))
        while not Q.empty() or expand == self.goal:
            f, g, pos, action = Q.get()
            while pos in visited:
                f, g, pos, action = Q.get()
            visited.append(pos)
            parent_dict[str(pos)] = (expand, action)

            successors = self.get_successors(pos)
            for i in range(len(successors)):
                succ, action = successors[i]
                Q.put((g + 1 + self.heuristic(succ), g + 1, succ, action))

            expand = pos

        plan = []
        while expand:
            pred, action = parent_dict[str(expand)]
            plan.append(action)
            expand = pred
        plan.reverse()

        return plan


class DStarLite(object):
    """docstring for DStarLite"""

    def __init__(self, start, goal, layout):
        self.start = start
        self.goal = goal
        self.layout = layout
