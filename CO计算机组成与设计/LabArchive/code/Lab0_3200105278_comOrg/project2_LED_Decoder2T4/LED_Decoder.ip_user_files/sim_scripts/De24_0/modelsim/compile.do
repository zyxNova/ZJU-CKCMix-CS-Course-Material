vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu \
"../../../../LED_Decoder.gen/sources_1/ip/De24_0/sources_1/new/De24.v" \
"../../../../LED_Decoder.gen/sources_1/ip/De24_0/sim/De24_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

