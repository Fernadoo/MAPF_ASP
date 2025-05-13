# mv this file to the root dir and then execute it
import os

goals = {
    3: '1_1 1_3 3_1 3_3 3_2',
    4: '1_1 1_4 4_1 4_4 2_2',
    5: '1_1 1_5 5_1 5_5 2_2',
    6: '1_1 1_6 6_1 6_6 2_2',
}

for s in [1, 2, 3]:
    for M in [3, 4, 5, 6]:
        for N in [2, 3, 4, 5]:
            AGENTS = ' '.join([f'sensor_{s}' for i in range(N)])
            MAP = f'{M}by{M}'
            GOALS = ' '.join(goals[M].split(' ')[:N])
            cmd = f'python run.py --agents {AGENTS} --map {MAP} --goals {GOALS}'
            print(cmd)
            out = f's{s}_map{M}_agent{N}.lp'
            print(out)

            os.system(cmd)
            os.system(f'mv tmp.lp feasibility/files/{out}')
        # exit(0)
