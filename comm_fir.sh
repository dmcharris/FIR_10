ghdl -a FIR_package.vhd

ghdl -a clk_div.vhd

ghdl -a Data_Gen.vhd

ghdl -a REG.vhd

ghdl -a MAC.vhd

ghdl -a FSM.vhd

ghdl -a FIR_10.vhd


ghdl -a FIR_tb.vhd

ghdl -e FIR_tb

ghdl -r FIR_tb --vcd=FIR_10.vcd

gtkwave/bin/gtkwave FIR_10.vcd