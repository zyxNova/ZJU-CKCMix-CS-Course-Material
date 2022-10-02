vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu \
"../../../../LED_Decoder.gen/sources_1/ip/De24_0/sources_1/new/De24.v" \
"../../../../LED_Decoder.gen/sources_1/ip/De24_0/sim/De24_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

