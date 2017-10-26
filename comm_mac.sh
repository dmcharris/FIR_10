ghdl -a MAC.vhd

ghdl -a MAC_tb.vhd

ghdl -e MAC_tb

ghdl -r MAC_tb --vcd=MAC.vcd

gtkwave/bin/gtkwave MAC.vcd