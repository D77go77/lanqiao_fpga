# LED
set_property IOSTANDARD LVCMOS33 [get_ports {LD[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD[0]}]
set_property PACKAGE_PIN P11 [get_ports {LD[7]}]
set_property PACKAGE_PIN P10 [get_ports {LD[6]}]
set_property PACKAGE_PIN N11 [get_ports {LD[5]}]
set_property PACKAGE_PIN N10 [get_ports {LD[4]}]
set_property PACKAGE_PIN P13 [get_ports {LD[3]}]
set_property PACKAGE_PIN P12 [get_ports {LD[2]}]
set_property PACKAGE_PIN M14 [get_ports {LD[1]}]
set_property PACKAGE_PIN N14 [get_ports {LD[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN G11 [get_ports clk]
set_property PACKAGE_PIN B6 [get_ports rst]
#FLASH
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]