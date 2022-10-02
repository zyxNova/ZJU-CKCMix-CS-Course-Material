set_property -dict { PACKAGE_PIN AA10  IOSTANDARD LVCMOS15 } [get_ports {sw[0]}]
set_property -dict { PACKAGE_PIN AB10  IOSTANDARD LVCMOS15 } [get_ports {sw[1]}]

set_property -dict { PACKAGE_PIN W23  IOSTANDARD LVCMOS33 } [get_ports {LED[0]}]
set_property -dict { PACKAGE_PIN AB26  IOSTANDARD LVCMOS33 } [get_ports {LED[1]}]
set_property -dict { PACKAGE_PIN Y25  IOSTANDARD LVCMOS33 } [get_ports {LED[2]}]
set_property -dict { PACKAGE_PIN AA23  IOSTANDARD LVCMOS33 } [get_ports {LED[3]}]