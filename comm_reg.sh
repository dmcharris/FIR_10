ghdl -a REG.vhd

ghdl -a REG_tb.vhd

ghdl -e REG_tb

ghdl -r REG_tb --vcd=REG.vcd

gtkwave/bin/gtkwave REG.vcd