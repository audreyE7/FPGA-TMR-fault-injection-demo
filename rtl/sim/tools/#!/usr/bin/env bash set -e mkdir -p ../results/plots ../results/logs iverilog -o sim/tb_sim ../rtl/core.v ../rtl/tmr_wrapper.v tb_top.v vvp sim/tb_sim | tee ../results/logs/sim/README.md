# Rad-Tolerant FPGA Demo — TMR + Fault Injection

**Goal:** demonstrate a simple Triple Modular Redundancy (TMR) design on a small soft-core and quantify fault tolerance using software fault-injection. This project shows how TMR + periodic scrubbing mitigates single-event upsets (SEUs) and provides a reproducible testbench.

## What’s included
- `rtl/` — Verilog RTL: `core.v`, `tmr_wrapper.v`
- `sim/` — simulation harness for Icarus Verilog + VCD waveform
- `tools/fault_inject.py` — generator and runner for injection schedules & plots
- `results/plots/` — generated figures and analysis

## How to run (fast)
Requirements: Icarus Verilog (iverilog), Python 3 (numpy, matplotlib, pandas), GTKWave (optional)
```bash
# from repository root
python3 -m pip install -r requirements.txt
cd sim
bash run_sim.sh
# run the Python injection & plotting
python3 ../tools/fault_inject.py
# open waveform.vcd in gtkwave if desired
gtkwave waveform.vcd
