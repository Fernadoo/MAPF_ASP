import os
import time
from itertools import product
try:
    import clingo
except():
    clingo = None


class ASPSolver():

    def __init__(self, map_config=None, agent_config=None, goal_config=None,
                 lp_file=None, sol_file=None):
        if clingo is None:
            raise RuntimeError('Install clingo first!')
        if sol_file:
            self.sol_file = sol_file
        else:
            if lp_file is None:
                lp_file = self.parse(map_config,
                                     agent_config,
                                     goal_config)
            self.lp_file = lp_file
            self.sol_file = None

        self.N = len(agent_config.keys())

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

            # Global settings - global states
            lp.write('\n')
            n = len(agent_config.keys())
            SLs = ', '.join([f'L{i}' for i in range(1, n + 1)])
            SGs = ', '.join([f'G{i}' for i in range(1, n + 1)])
            S = f'S = ({SLs}, {SGs}), '
            constraints = ''
            goals = ''
            Ls = ''
            for i in range(1, n + 1):
                constraints += '\n\t'
                for j in range(i + 1, n + 1):
                    constraints += f'L{i} != L{j}, '
                goals += f'goal{i}(G{i}), '
                Ls += f'\tL{i} = (X{i}, Y{i}), ' \
                      f'cell(X{i}, Y{i}), ' \
                      f'not block(X{i}, Y{i}),\n'
            goals += '\n'
            Ls = Ls[:-2] + '.\n'
            lp.write('gState(S) :-' + S + constraints + goals + Ls)

            # Global settings - transition
            lp.write('\n')
            action_profile = ', '.join([f'A{i}' for i in range(1, n + 1)])
            L1s = ', '.join([f'L1{i}' for i in range(1, n + 1)])
            G1s = ', '.join([f'G1{i}' for i in range(1, n + 1)])
            S1 = f'\tS1 = ({L1s}, {G1s}),\n'
            L2s = ', '.join([f'L2{i}' for i in range(1, n + 1)])
            G2s = ', '.join([f'G2{i}' for i in range(1, n + 1)])
            S2 = f'\tS2 = ({L2s}, {G2s}),\n'
            L1_decomp = ', '.join([f'L1{i} = (X1{i}, Y1{i})'
                                   for i in range(1, n + 1)])
            L2_decomp = ', '.join([f'L2{i} = (X2{i}, Y2{i})'
                                   for i in range(1, n + 1)])
            move = ',\n\t'.join([f'move(X1{i}, Y1{i}, A{i}, X2{i}, Y2{i})'
                                 for i in range(1, n + 1)])
            noswap = ''
            for i in range(1, n + 1):
                noswap += '\t'
                for j in range(i + 1, n + 1):
                    noswap += f'(L1{i}, L1{j}) != (L2{j}, L2{i}), '
                noswap += '\n'
            noswap = noswap[:-5] + '.\n'
            lp.write(f'trans(S1, {action_profile}, S2) :- '
                     + 'gState(S1), gState(S2), \n'
                     + S1
                     + S2
                     + f'\t{L1_decomp},\n'
                     + f'\t{L2_decomp},\n'
                     + f'\t{move},\n'
                     + noswap)

            # Global settings - moves and actions
            lp.write('\n')
            lp.write(
                'move(X, Y, up, X-1, Y) :- action(X, Y, up).\n'
                'move(X, Y, down, X+1, Y) :- action(X, Y, down).\n'
                'move(X, Y, left, X, Y-1) :- action(X, Y, left).\n'
                'move(X, Y, right, X, Y+1) :- action(X, Y, right).\n'
                'move(X, Y, nil, X, Y) :- action(X, Y, nil).\n'
                '\n'
                'action(X, Y, up) :- cell(X, Y), cell(X-1, Y),\n'
                '\tnot block(X, Y), not block(X-1, Y).\n'
                'action(X, Y, down) :- cell(X, Y), cell(X+1, Y),\n'
                '\tnot block(X, Y), not block(X+1, Y).\n'
                'action(X, Y, left) :- cell(X, Y), cell(X, Y-1),\n'
                '\tnot block(X, Y), not block(X, Y-1).\n'
                'action(X, Y, right) :- cell(X, Y), cell(X, Y+1),\n'
                '\tnot block(X, Y), not block(X, Y+1).\n'
                'action(X, Y, nil) :- cell(X, Y), cell(X, Y),\n'
                '\tnot block(X, Y), not block(X, Y).\n'
            )

            # Global settings - goal states
            lp.write('\n')
            Gs = ', '.join([f'G{i}' for i in range(1, n + 1)])
            goals = ', '.join([f'goal{i}(G{i})' for i in range(1, n + 1)])
            lp.write('goal_gState(S) :- gState(S),\n'
                     + f'\tS = ({Gs}, {Gs}),\n'
                     + f'\t{goals}.\n')

            # Agent settings - agent states
            lp.write('\n')
            Others = ', '.join([f'Other{i}' for i in range(2, n + 1)])
            nears = ', '.join([f'near(Self, Other{i})'
                               for i in range(2, n + 1)])
            lp.write(f'aState(AS) :- AS = (Self, {Others}, Goal),\n'
                     + '\tSelf = (X, Y), cell(X, Y), not block(X, Y),\n'
                     + '\tGoal = (Xg, Yg), cell(Xg, Yg), not block(Xg, Yg),\n'
                     + f'\t{nears}.\n')

            # Agent settings - near
            lp.write('\n')
            Radius = len(agent_config['p1']) // 2
            lp.write(
                'near(Self, empty) :- Self = (X1, Y1), cell(X1, Y1).\n'
                'near(Self, Other) :- Self != Other,\n'
                '    Self = (X1, Y1), Other = (X2, Y2),\n'
                f'    |X1-X2| <= {Radius}, |Y1-Y2| <= {Radius},\n'
                '    cell(X1, Y1), cell(X2, Y2),\n'
                '    not block(X1, Y1), not block(X2, Y2).\n'
            )

            # Agent settings - available actions
            lp.write('\n')
            lp.write(
                'avai_action(AS, Action) :- aState(AS),\n'
                '\tAS = (Self' + ', _' * n + '),\n'
                '\tSelf = (X, Y), action(X, Y, Action).\n'
            )

            # Agent settings - goal agent state
            lp.write('\n')
            for i in range(1, n + 1):
                lp.write(
                    f'goal{i}_aState(AS) :- aState(AS), '
                    f'AS = (G{i}, ' + '_, ' * (n - 1) + f'G{i}), '
                    f'goal{i}(G{i}).\n'
                )

            # Observation model - exponential reduction
            lp.write('\n')
            Ls = ', '.join([f'L{i}' for i in range(1, n + 1)])
            Gs = ', '.join([f'G{i}' for i in range(1, n + 1)])
            Other_str = ', '.join([f'Others{i}' for i in range(2, n + 1)])
            for i in range(1, n + 1):
                Others = [f'L{j}' for j in range(1, n + 1)]
                Self = Others[i - 1]
                Others.remove(Self)
                for profile in product([1, 0], repeat=(n - 1)):
                    ASs = ''
                    nears = ''
                    for j, flag in enumerate(profile):
                        if flag == 1:
                            ASs += f'{Others[j]}, '
                            nears += f'near(Self, {Others[j]}), '
                        else:
                            ASs += 'empty, '
                            nears += f'not near(Self, {Others[j]}), '
                    AS = f'AS = (Self, {ASs}G{i}),'
                    nears = nears[:-2] + '.\n'
                    lp.write(
                        f'obs{i}(S, AS) :- gState(S),\n'
                        f'\tS = ({Ls}, {Gs}), \n'
                        f'\tSelf = L{i}, '
                        f'({Other_str}) = ({", ".join(Others)}),\n'
                        f'\taState(AS), {AS}\n'
                        f'\t{nears}'
                    )

            # Policy restrictions
            lp.write('\n')
            for i in range(1, n + 1):
                lp.write(f'do{i}(AS, nil) :- goal{i}_aState(AS).\n')
                lp.write(
                    '{ ' + f'do{i}(AS, A): avai_action(AS, A)' + ' }'
                    ' = 1 :- \n'
                    '\taState(AS), '
                    'AS = (Self, ' + '_, ' * (n - 1) + 'Goal), '
                    f'Self != Goal, goal{i}(Goal).\n'
                )

            # Reachability
            lp.write('\n')
            lp.write('reached(S) :- goal_gState(S).\n')
            induction = 'reached(S1) :- gState(S1), reached(S2),\n'
            for i in range(1, n + 1):
                induction += f'\tobs{i}(S1, AS{i}), do{i}(AS{i}, A{i}),\n'
            lp.write(induction)
            lp.write(f'\ttrans(S1, {action_profile}, S2).\n')
            lp.write(':- gState(S), not reached(S).\n')

            # Shorter notation
            lp.write('\n')
            Ls = ', '.join([f'L{i}' for i in range(1, n + 1)])
            for i in range(1, n + 1):
                lp.write(f'p{i}({Ls}, A) :- do{i}(({Ls}, _), A).\n')

            # show results
            for i in range(1, n + 1):
                lp.write(f'#show p{i}/{n + 1}.\n')

        print('Logic program translated.')
        return 'tmp.lp'

    def encode(self, parsed_map, parsed_agents):
        pass

    def solve(self):
        if self.sol_file:
            # no need to compute solving time
            solution_file = self.sol_file
        else:
            t0 = time.time()
            os.system(f'clingo {self.lp_file} > tmp.sol')
            t1 = time.time()

            print(f'Solving time: {t1 - t0}')
            print(f'Policy saved as tmp.sol\n')

            solution_file = 'tmp.sol'

        n = self.N
        policy = dict(zip([f'p{i}' for i in range(1, n + 1)],
                          [dict() for i in range(n)]))
        # print(policy)
        with open(f'{solution_file}', 'r') as f:
            line = f.readline()
            while line:
                if line.startswith('UNSATISFIABLE'):
                    print('UNSATISFIABLE')
                    exit()
                if line.startswith('Answer'):
                    num = eval(line.split(':')[-1])
                    policy['sol_id'] = num
                    segments = f.readline().split(' ')
                    for p in segments:
                        p = p.replace('empty', 'None').replace('\n', '')
                        p = p.replace('nil', '\"nil\"')
                        p = p.replace('up', '\"up\"')
                        p = p.replace('down', '\"down\"')
                        p = p.replace('left', '\"left\"')
                        p = p.replace('right', '\"right\"')
                        player = p[:p.index('(')]
                        content = eval(p[p.index('('):])
                        state, action = str(content[:-1]), content[-1]
                        policy[player][state] = action
                    break
                line = f.readline()

        # print(policy)
        # exit()
        return policy
