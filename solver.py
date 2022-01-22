import os
try:
    import clingo
except():
    clingo = None

class ASPSolver():

    def __init__(self, map_config=None, agent_config=None, goal_config=None,
                 lp_file=None):
        if clingo is None:
            raise RuntimeError('Install clingo first!')
        if lp_file is None:
            lp_file = self.parse(map_config,
                                 agent_config,
                                 goal_config)
        self.lp_file = lp_file

    def parse(self, map_config, agent_config, goal_config):
        with open('tmp.lp', 'w') as lp:

            # Prespecified parameters
            lp.write(f'cell(0..{len(map_config) - 1}, '
                     f'0..{len(map_config[0]) - 1}).\n')
            for i in range(len(map_config)):
                for j in range(len(map_config[0])):
                    if map_config[i, j] == 1:
                        lp.write(f'block({i}, {j}).\n')
            for name in goal_config:
                i = eval(name.split('p')[-1])
                lp.write(f'goal{i}(G) :- G = {goal_config[name]}.\n')

            # Global settings
            n = len(agent_config.keys())
            
        os.system('cat examples/2agents_template.lp >> tmp.lp')
        return 'tmp.lp'

    def encode(self, parsed_map, parsed_agents):
        pass

    def solve(self):
        os.system(f'clingo {self.lp_file} > tmp.sol')
        print(f'Policy saved as tmp.sol\n')

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
