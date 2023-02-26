onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib AND32_0_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {AND32_0.udo}

run -all

quit -force
