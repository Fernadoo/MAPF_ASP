from solver import ASPSolver
from agent import Agent
from game import Game
from animator import Animation

import argparse
import os

import numpy as np


def parse_agent_from_file(agent_config_list):
    PREFIX = 'configs/agents/'
    POSTFIX = '.agent'
    sensor_dict = dict()
    for i, agent_config in enumerate(agent_config_list):
        if not os.path.exists(PREFIX + agent_config + POSTFIX):
            raise ValueError(f'Config for agent {i + 1} does not exist!')
        sensor = []
        with open(PREFIX + agent_config + POSTFIX, 'r') as f:
            line = f.readline()
            while line:
                row = []
                for char in line:
                    if char == '.':
                        row.append(0)
                    elif char == '*':
                        row.append(1)
                    else:
                        continue
                sensor.append(row)
                line = f.readline()
        sensor_dict[f'p{i + 1}'] = np.array(sensor)
    return sensor_dict


def parse_map_from_file(map_config):
    PREFIX = 'configs/maps/'
    POSTFIX = '.map'
    if not os.path.exists(PREFIX + map_config + POSTFIX):
        raise ValueError('Map config does not exist!')
    layout = []
    with open(PREFIX + map_config + POSTFIX, 'r') as f:
        line = f.readline()
        while line:
            row = []
            for char in line:
                if char == '.':
                    row.append(0)
                elif char == '@':
                    row.append(1)
                else:
                    continue
            layout.append(row)
            line = f.readline()
    return np.array(layout)


def parse_goals(goals):
    goal_dict = dict()
    for i, goal in enumerate(goals):
        goal_dict[f'p{i + 1}'] = eval(goal.replace('_', ','))
    return goal_dict


def get_args():
    parser = argparse.ArgumentParser(
        description='Partially Observable Multi-Agent Path Finding.'
    )

    parser.add_argument('--agents', dest='agents', type=str, nargs='+',
                        help='Specify a team of agents')
    parser.add_argument('--map', dest='map', type=str,
                        help='Specify a map')
    parser.add_argument('--goals', dest='goals', type=str, nargs='+',
                        help='Specify the goals for each agent,'
                             'e.g. 2_0 0_2')
    parser.add_argument('--lp-file', dest='lp_file', type=str,
                        help='Use an existing human-written lp file')
    parser.add_argument('--vis', dest='vis', action='store_true',
                        help='Visulize the process')
    parser.add_argument('--save', dest='save', type=str,
                        help='Specify the path to save the animation')

    args = parser.parse_args()
    args.agents = parse_agent_from_file(args.agents)
    args.map = parse_map_from_file(args.map)
    args.goals = parse_goals(args.goals)
    args.lp_file = 'examples/' + args.lp_file
    args.save = 'results/' + args.save

    return args


def show_args(args):
    args = vars(args)
    for key in args:
        print(f'{key.upper()}:')
        if key == 'agents':
            for agent in args[key]:
                print(f'{agent}:')
                print(args[key][agent])
        else:
            print(args[key])
        print('-------------\n')


if __name__ == '__main__':
    args = get_args()
    show_args(args)

    exit()
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
    if args.vis:
        animator = Animation(layout, starts, goals, history)
        animator.show()
        if args.save:
            animator.save('results/pomapf.gif', speed=1)
