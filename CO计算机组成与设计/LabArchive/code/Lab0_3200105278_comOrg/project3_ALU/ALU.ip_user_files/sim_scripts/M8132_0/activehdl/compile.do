vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../ALU.gen/sources_1/ip/M8132_0/src/M8132.v" \
"../../../../ALU.gen/sources_1/ip/M8132_0/sim/M8132_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

