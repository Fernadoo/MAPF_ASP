# Partially Observable Multi-Agent Path Finding via Answer Set Programming

<!-- <img src="results/medium.gif" alt="3x3 Grid World" style="zoom:33%;" /> -->
<!-- <video src='results/2_rooms.mp4' width=80/> -->



https://github.com/user-attachments/assets/449c64e7-0c40-4b99-8d99-4c2af5992cd8



[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![arXiv](https://img.shields.io/badge/arXiv-2305.16203-b31b1b.svg)](https://arxiv.org/abs/2305.16203)
[![Formalism](https://img.shields.io/badge/Formalism-ASP-orange)](https://www.cs.utexas.edu/~vl/papers/wiasp.pdf)
[![Solver](https://img.shields.io/badge/Solver-clingo-navy)](https://potassco.org/clingo/)


### Conda Env & Dependence:

```shell
conda create -n mapf python=3.9.7
conda activate mapf
pip install -r requirements.txt
```

### Usage:

```shell
usage: run.py [-h] [--agents AGENTS [AGENTS ...]] [--map MAP] [--goals GOALS [GOALS ...]] [--lp-file LP_FILE] [--vis] [--save SAVE]

Partially Observable Multi-Agent Path Finding.

optional arguments:
  -h, --help            show this help message and exit
  --agents AGENTS [AGENTS ...]
                        Specify a team of agents
  --map MAP             Specify a map
  --goals GOALS [GOALS ...]
                        Specify the goals for each agent,e.g. 2_0 0_2
  --lp-file LP_FILE     Use an existing human-written lp file
  --vis                 Visulize the process
  --save SAVE           Specify the path to save the animation
```

Example:

```shell
python run.py --agents sensor_1 sensor_1 --map 3_3 --goals 0_1 2_0 --lp-file poma2asp.lp --vis --save pomapf.gif
```

