transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/aasan/OneDrive/Documentos/Poli/10_Semester/OrgArcComp/projectTomasulo/Tomasulo/Ldstr/RegFileTomasulo.vhd}
vcom -93 -work work {C:/Users/aasan/OneDrive/Documentos/Poli/10_Semester/OrgArcComp/projectTomasulo/Tomasulo/Ldstr/MapTable.vhd}
vcom -93 -work work {C:/Users/aasan/OneDrive/Documentos/Poli/10_Semester/OrgArcComp/projectTomasulo/Tomasulo/Ldstr/DecoderLDSTR.vhd}
vcom -93 -work work {C:/Users/aasan/OneDrive/Documentos/Poli/10_Semester/OrgArcComp/projectTomasulo/Tomasulo/Ldstr/Mem.vhd}
vcom -93 -work work {C:/Users/aasan/OneDrive/Documentos/Poli/10_Semester/OrgArcComp/projectTomasulo/Tomasulo/Ldstr/LdstrQueue.vhd}
vcom -93 -work work {C:/Users/aasan/OneDrive/Documentos/Poli/10_Semester/OrgArcComp/projectTomasulo/Tomasulo/Ldstr/AdderMem.vhd}

vcom -93 -work work {C:/Users/aasan/OneDrive/Documentos/Poli/10_Semester/OrgArcComp/projectTomasulo/Tomasulo/Ldstr/ldstr_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  Ldstr_tb

add wave *
view structure
view signals
run 10 ns
