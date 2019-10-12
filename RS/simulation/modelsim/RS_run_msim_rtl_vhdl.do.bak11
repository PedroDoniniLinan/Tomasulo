transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/0# POLI_Endgame-Algm me tira daqui/Org Arq II/Projeto/Tomasulo/RS/rs.vhd}

vcom -93 -work work {D:/0# POLI_Endgame-Algm me tira daqui/Org Arq II/Projeto/Tomasulo/RS/rs_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  rs_tb

add wave *
view structure
view signals
run 20 us
