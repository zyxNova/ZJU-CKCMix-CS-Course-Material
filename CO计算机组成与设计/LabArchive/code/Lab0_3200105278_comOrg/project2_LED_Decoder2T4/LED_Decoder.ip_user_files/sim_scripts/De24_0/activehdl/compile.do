vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../LED_Decoder.gen/sources_1/ip/De24_0/sources_1/new/De24.v" \
"../../../../LED_Decoder.gen/sources_1/ip/De24_0/sim/De24_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

