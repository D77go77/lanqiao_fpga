# RST
set_property PACKAGE_PIN B6 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

# Global Clock
set_property PACKAGE_PIN G11 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]

# I2C
set_property PACKAGE_PIN E11 [get_ports scl]
set_property PACKAGE_PIN M10 [get_ports sda]
set_property IOSTANDARD LVCMOS33 [get_ports scl]
set_property IOSTANDARD LVCMOS33 [get_ports sda]


# UART
#set_property PACKAGE_PIN F12 [get_ports tx]
#set_property PACKAGE_PIN E12 [get_ports rx]
#set_property IOSTANDARD LVCMOS33 [get_ports rx]
#set_property IOSTANDARD LVCMOS33 [get_ports tx]

# RTC
#set_property PACKAGE_PIN A13 [get_ports rtc_data]
#set_property PACKAGE_PIN A10 [get_ports rtc_sclk]
#set_property PACKAGE_PIN A12 [get_ports rtc_ce]

#set_property IOSTANDARD LVCMOS33 [get_ports rtc_data]
#set_property IOSTANDARD LVCMOS33 [get_ports rtc_sclk]
#set_property IOSTANDARD LVCMOS33 [get_ports rtc_ce]


# Buzz
# set_property PACKAGE_PIN L5 [get_ports buz]
# set_property IOSTANDARD LVCMOS33 [get_ports buz]

# Key
set_property PACKAGE_PIN M5 [get_ports {key_in[0]}]
set_property PACKAGE_PIN M4 [get_ports {key_in[1]}]
set_property PACKAGE_PIN P5 [get_ports {key_in[2]}]
set_property PACKAGE_PIN N4 [get_ports {key_in[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {key_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[3]}]

# LED
#set_property PACKAGE_PIN P11 [get_ports {led[7]}]
#set_property PACKAGE_PIN P10 [get_ports {led[6]}]
#set_property PACKAGE_PIN N11 [get_ports {led[5]}]
#set_property PACKAGE_PIN N10 [get_ports {led[4]}]
#set_property PACKAGE_PIN P13 [get_ports {led[3]}]
#set_property PACKAGE_PIN P12 [get_ports {led[2]}]
#set_property PACKAGE_PIN M14 [get_ports {led[1]}]
#set_property PACKAGE_PIN N14 [get_ports {led[0]}]

#set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

# SEG
 set_property PACKAGE_PIN D3 [get_ports {seg[0]}]
 set_property PACKAGE_PIN C3 [get_ports {seg[1]}]
 set_property PACKAGE_PIN A4 [get_ports {seg[2]}]
 set_property PACKAGE_PIN A3 [get_ports {seg[3]}]
 set_property PACKAGE_PIN B3 [get_ports {seg[4]}]
 set_property PACKAGE_PIN A2 [get_ports {seg[5]}]
 set_property PACKAGE_PIN B5 [get_ports {seg[6]}]
 set_property PACKAGE_PIN A5 [get_ports {seg[7]}]

 set_property PACKAGE_PIN B2 [get_ports {sel[0]}]
 set_property PACKAGE_PIN B1 [get_ports {sel[1]}]
 set_property PACKAGE_PIN C5 [get_ports {sel[2]}]
 set_property PACKAGE_PIN C4 [get_ports {sel[3]}]
 set_property PACKAGE_PIN E4 [get_ports {sel[4]}]
 set_property PACKAGE_PIN D4 [get_ports {sel[5]}]
 set_property PACKAGE_PIN F3 [get_ports {sel[6]}]
 set_property PACKAGE_PIN F2 [get_ports {sel[7]}]

 set_property IOSTANDARD LVCMOS33 [get_ports {sel[0]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {sel[1]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {sel[2]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {sel[3]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {sel[4]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {sel[5]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {sel[6]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {sel[7]}]

 set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
 set_property IOSTANDARD LVCMOS33 [get_ports {seg[7]}]

# FLASH
set_property PACKAGE_PIN D13 [get_ports spi_clk]
set_property PACKAGE_PIN F14 [get_ports spi_miso]
set_property PACKAGE_PIN G14 [get_ports spi_mosi]
set_property PACKAGE_PIN D12 [get_ports spi_csn]

set_property IOSTANDARD LVCMOS33 [get_ports spi_clk]
set_property IOSTANDARD LVCMOS33 [get_ports spi_miso]
set_property IOSTANDARD LVCMOS33 [get_ports spi_mosi]
set_property IOSTANDARD LVCMOS33 [get_ports spi_csn]
