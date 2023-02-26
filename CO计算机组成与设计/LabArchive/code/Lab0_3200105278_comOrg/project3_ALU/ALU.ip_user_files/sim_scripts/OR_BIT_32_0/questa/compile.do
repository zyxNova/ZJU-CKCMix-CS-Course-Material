vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu \
"../../../../ALU.gen/sources_1/ip/OR_BIT_32_0/src/OR_BIT_32.v" \
"../../../../ALU.gen/sources_1/ip/OR_BIT_32_0/sim/OR_BIT_32_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

