vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu \
"../../../../ALU.gen/sources_1/ip/SEXT1_32_0/src/SEXT1_32.v" \
"../../../../ALU.gen/sources_1/ip/SEXT1_32_0/sim/SEXT1_32_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

