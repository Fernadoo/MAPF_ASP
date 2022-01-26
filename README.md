# Partially Observable Multi-Agent Path Finding via Answer Set Programming

<!-- <img src="results/medium.gif" alt="3x3 Grid World" style="zoom:33%;" /> -->
<!-- <video src='results/2_rooms.mp4' width=80/> -->

https://user-images.githubusercontent.com/42331572/151119754-e3708d1c-e7d4-47fa-baae-67652e80735c.mp4

### Dependence:

```shell
pip install -r requirement.txt
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

