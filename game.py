import numpy as np


class Game():

    def __init__(self, starts, goals, agents, layout):
        self.init_state = {
            'POSITIONS': starts,
            'GOALS': goals,
        }
        self.reach_goal = np.zeros(len(agents))
        self.agents = agents
        for agent in self.agents:
            agent.register(starts[agent.name], goals[agent.name])
        self.layout = layout

    def pos_profile(self, state):
        profile = []
        for i, agent in enumerate(self.agents):
            profile.append(state['POSITIONS'][agent.name])
        return profile

    def is_end(self):
        # print(self.reach_goal)
        return np.all(self.reach_goal == np.ones(len(self.reach_goal)))

    def run(self):
        state = self.init_state
        histry = [self.pos_profile(state)]
        while True:
            pred_profile = self.pos_profile(state)
            print(pred_profile)

            succ_profile = []
            for agent in self.agents:
                obs = agent.observe(state)
                action = agent.get_action(obs)
                print(f'{agent.name}: {obs} -> {action}')
                succ_profile.append(agent.move(state['POSITIONS'][agent.name],
                                               action))

            for i in range(len(succ_profile)):
                for j in range(i + 1, len(succ_profile)):
                    if succ_profile[i] == succ_profile[j]:
                        print('Vertex conflict: '
                              '{pred_profile[i]}-{pred_profile[j]}!')
                        break
                    elif succ_profile[i] == pred_profile[j] and \
                            succ_profile[j] == pred_profile[i]:
                        print('Edge conflict: '
                              '{pred_profile[i]}-{pred_profile[j]}!')
                        break

            if succ_profile in histry:
                print(f'Loop back to {succ_profile}!')
                break

            histry.append(succ_profile)
            for i, agent in enumerate(self.agents):
                state['POSITIONS'][agent.name] = succ_profile[i]
                self.reach_goal[i] = int(state['POSITIONS'][agent.name]
                                         == state['GOALS'][agent.name])

            print('\t|\n\tV')
            if self.is_end():
                print('Goals reached!\n')
                break

        return histry
