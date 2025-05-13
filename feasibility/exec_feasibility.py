import os

files = os.listdir('./files')
for lp in files:
    out = lp.split('.')[0] + '.out'
    os.system(f'nohup clingo files/{lp} > logs/{out} &')
