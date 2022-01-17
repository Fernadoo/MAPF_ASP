import os

class ASPSolver():

    def __init__(self, map_config=None, agent_config=None, lp_file=None):
        if lp_file is None:
            parsed_map, parsed_agents = self.parse(map_config, agent_config)
            lp_file = self.encode(parsed_map, parsed_agents)
        self.lp_file = lp_file

    def parse(self, map_config, agent_config):
        pass

    def encode(self, parsed_map, parsed_agents):
        pass

    def solve(self):
        os.system(f'clingo {self.lp_file} > tmp.sol')

        p1, p2 = dict(), dict()
        with open('tmp.sol', 'r') as f:
            line = f.readline()
            while line:
                if line.startswith('Answer'):
                    num = eval(line.split(':')[-1])
                    policy = f.readline().split(' ')
                    for p in policy:
                        p = p.replace('\n', '').replace(',yes', '').replace(',no', '').replace('empty,', 'None|')
                        p = p.replace('),', ')|')
                        if p.startswith('p1'):
                            token = p.split('p1')[-1][1:-1].split('|')
                            state = f'({eval(token[0])}, {eval(token[1])})'
                            action = token[-1]
                            p1[state] = action
                        elif p.startswith('p2'):
                            token = p.split('p2')[-1][1:-1].split('|')
                            state = f'({eval(token[0])}, {eval(token[1])})'
                            action = token[-1]
                            p2[state] = action
                    break
                line = f.readline()

        policy = {'sol_id': num, 'p1': p1, 'p2': p2}
        return policy
