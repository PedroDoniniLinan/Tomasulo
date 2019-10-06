transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {RS.vho}

vcom -93 -work work {D:/0# POLI_Endgame-Algm me tira daqui/Org Arq II/Projeto/RS/rs_tb.vhd}

vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /NA=RS_vhd.sdo -L altera -L altera_lnsim -L cyclonev -L gate_work -L work -voptargs="+acc"  rs_tb

add wave *
view structure
view signals
run 20 us
