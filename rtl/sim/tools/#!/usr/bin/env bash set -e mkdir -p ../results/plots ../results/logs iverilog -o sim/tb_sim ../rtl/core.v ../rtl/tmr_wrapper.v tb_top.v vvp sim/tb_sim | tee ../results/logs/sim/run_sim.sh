#!/usr/bin/env bash
set -e
mkdir -p ../results/plots ../results/logs
iverilog -o sim/tb_sim ../rtl/core.v ../rtl/tmr_wrapper.v tb_top.v
vvp sim/tb_sim | tee ../results/logs/sim_stdout.log
# waveform.vcd created — view in gtkwave if desired
