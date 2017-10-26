ghdl -a FIR_package.vhd

ghdl -a FSM.vhd

ghdl -a FSM_tb.vhd

ghdl -e FSM_tb

ghdl -r FSM_tb --vcd=FSM.vcd

gtkwave/bin/gtkwave FSM.vcd