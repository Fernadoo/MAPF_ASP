import numpy as np


class Game():

    def __init__(self, starts, goals, agents):
        self.init_state = (starts[0], starts[1], goals[0], goals[1])
        self.reach_goal = (0, 0)
        self.agents = agents

    def is_end(self):
        return np.all(self.reach_goal == (1, 1))

    def run(self):
        state = self.init_state
        histry = [state]
        while True:
            print(state)
            o1 = self.agents[0].observe(state)
            o2 = self.agents[1].observe((state[1],
                                         state[0],
                                         state[2],
                                         state[3]))
            a1 = self.agents[0].get_action(o1)
            a2 = self.agents[1].get_action(o2)
            print(f'1: {o1} -> {a1}')
            print(f'2: {o2} -> {a2}')
            print('-----\n')
            succ1 = self.agents[0].move(state[0], a1)
            succ2 = self.agents[1].move(state[1], a2)
            if (succ2, succ1) == state[:2]:
                print('Edge conflict!')
                break
            elif succ1 == succ2:
                print('Vertex conflict!')
                break
            state = (succ1, succ2, state[2], state[3])
            if state in histry:
                print(f'Loop back to {state}!')
                break
            histry.append(state)

            self.reach_goal = tuple((int(state[0] == state[2]),
                                     int(state[1] == state[3])))
            if self.is_end():
                print('Goals reached!')
                break
        return histry
