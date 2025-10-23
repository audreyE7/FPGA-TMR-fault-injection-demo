# fault_inject.py
import time, random, subprocess, os, csv
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Parameters
sim_time_secs = 1.0   # wall-clock run (we'll actually rely on iverilog runtime)
inject_rate = 0.01    # prob per cycle to inject
ticks = 5000

# Randomly decide injection cycles and data
rng = np.random.RandomState(42)
inject_cycles = rng.choice([0,1], size=ticks, p=[1-inject_rate, inject_rate])
inject_data = rng.randint(0, 256, size=ticks)

# write a simple CSV file the testbench can read as "schedule"
with open('sim/inject_schedule.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    for i in range(ticks):
        if inject_cycles[i]:
            writer.writerow([i, inject_data[i]])

print("Wrote sim/inject_schedule.csv with {} injections".format(inject_cycles.sum()))

# Run iverilog + vvp (assumes run_sim.sh handles it and produces waveform.vcd)
subprocess.run(['bash', 'sim/run_sim.sh'])

# After simulation: parse stdout or use GTKWave to export signals — for now, parse log
# simple postprocess: read sim log for occurrences of "INJECT" etc (if you print from tb)
# For demo, just create a plot of injection timeline
times = [i for i in range(ticks) if inject_cycles[i]]
vals  = [int(inject_data[i]) for i in times]
plt.figure(figsize=(8,2))
plt.scatter(times, vals, s=6)
plt.xlabel('Cycle')
plt.ylabel('Injected Byte')
plt.title('Fault injection events (schedule)')
plt.savefig('results/plots/injection_schedule.png', dpi=200)
print("Plot saved to results/plots/injection_schedule.png")
