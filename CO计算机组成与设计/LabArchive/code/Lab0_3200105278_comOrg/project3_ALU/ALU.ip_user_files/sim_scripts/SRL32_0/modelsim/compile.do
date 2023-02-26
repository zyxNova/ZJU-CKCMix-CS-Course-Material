vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu \
"../../../../ALU.gen/sources_1/ip/SRL32_0/src/SRL32.v" \
"../../../../ALU.gen/sources_1/ip/SRL32_0/sim/SRL32_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

