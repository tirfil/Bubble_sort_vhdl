set FLAG=-v -PALL_LIB --syn-binding --ieee=synopsys --std=93c -fexplicit

ghdl -a --work=WORK --workdir=ALL_LIB %FLAG% ..\VHDL\bsort.vhd
ghdl -a --work=RAM_LIB --workdir=ALL_LIB %FLAG% ..\VHDL\dp256x8.vhd

