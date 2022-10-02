vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu \
"../../../../ALU.gen/sources_1/ip/ADC32_0/src/ADC32.v" \
"../../../../ALU.gen/sources_1/ip/ADC32_0/sim/ADC32_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

