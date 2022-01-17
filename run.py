from solver import ASPSolver
from agent import Agent
from game import Game
from animator import Animation

import argparse

import numpy as np


def get_args():
    parser = argparse.ArgumentParser(
        description='Partially Observable Multi-Agent Path Finding.'
    )

    # parser.add_argument('--agents', dest='agents', type=str, nargs='+',
    #                     help='Specify a team of agents')
    # parser.add_argument('--map', dest='map', type=str,
    #                     help='Specify a map')
    # parser.add_argument('--goals', dest='goals', type=str,
    #                     help='Specify the goals for each agent')
    parser.add_argument('--lp-file', dest='lp_file', type=str,
                        help='Use an existing human-written lp file')
    # parser.add_argument('--vis', dest='vis', action='store_true',
    #                     help='Visulize the process')
    # parser.add_argument('--save', dest='save', type=str,
    #                     help='Specify the path to save the animation')
    return parser.parse_args()


if __name__ == '__main__':
    args = get_args()
    solver = ASPSolver(lp_file='examples/poma2asp.lp')
    policies = solver.solve()

    agent1 = Agent(name='p1', policy=policies['p1'])
    agent2 = Agent(name='p2', policy=policies['p2'])

    starts = ((2, 1), (0, 2))
    goals = ((0, 1), (2, 0))
    game = Game(starts, goals, agents=[agent1, agent2])
    history = game.run()
    # print(history)

    layout = np.array(
        [[0, 0, 0],
         [0, 1, 0],
         [0, 0, 0]]
    )

    animator = Animation(layout, starts, goals, history)
    # animator.show()
    animator.save('results/pomapf.gif', speed=1)
