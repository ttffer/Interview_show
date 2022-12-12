## Auto create IP integration with ip tcl file creator KY-H 20221127
# It will search ip_repo_paths and find custom IP
# Notice that if enable the dubug cores, 
# the IP name can not be changed or you will have to add debug net manually.

##########################################################################
####IP info####
#### ip name
set IP_Name "tcbCNN_121_c_25x64x10_IP"

set myip_version_name "user.org:user:$IP_Name:1.0"
set myip_instance_name "my_IP"

set BD_name design_1

set prj_name    "ip_integration_test1"
create_project $prj_name /home/kuanyu/A_zcu104_workplace/$prj_name -part xczu7ev-ffvc1156-2-e -force
set_property board_part xilinx.com:zcu104:part0:1.1 [current_project]
############ create Block design ###############
create_bd_design "design_1"
update_compile_order -fileset sources_1
############ Add IP catolog ###########
set_property  ip_repo_paths  /home/kuanyu/Desktop/vivado4IP [current_project]
update_ip_catalog

######create zynq######
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.4 zynq_ultra_ps_e_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]
######set PL clock 80hz, enable HP port######
set_property -dict [list CONFIG.PSU__USE__S_AXI_GP2 {1} CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {80}] [get_bd_cells zynq_ultra_ps_e_0]
######Add DMA simple Mode, Buffer size 26bit######
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
endgroup
set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_length_width {26} CONFIG.c_sg_include_stscntrl_strm {0}] [get_bd_cells axi_dma_0]

#####Add IP #####
startgroup
create_bd_cell -type ip -vlnv $myip_version_name $myip_instance_name
endgroup
##### Connect S2MM,MM2S to IP #####
connect_bd_intf_net [get_bd_intf_pins $myip_instance_name/m_axis] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]
connect_bd_intf_net [get_bd_intf_pins $myip_instance_name/s_axis] [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S]


#####auto connection #####
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/zynq_ultra_ps_e_0/pl_clk0 (78 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins $myip_instance_name/axi_clk]
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_FPD} Slave {/axi_dma_0/S_AXI_LITE} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {/zynq_ultra_ps_e_0/pl_clk0 (78 MHz)} Clk_xbar {/zynq_ultra_ps_e_0/pl_clk0 (78 MHz)} Master {/zynq_ultra_ps_e_0/M_AXI_HPM1_FPD} Slave {/axi_dma_0/S_AXI_LITE} ddr_seg {Auto} intc_ip {/ps8_0_axi_periph} master_apm {0}}  [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM1_FPD]
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/zynq_ultra_ps_e_0/pl_clk0 (78 MHz)} Clk_slave {Auto} Clk_xbar {Auto} Master {/axi_dma_0/M_AXI_MM2S} Slave {/zynq_ultra_ps_e_0/S_AXI_HP0_FPD} ddr_seg {Auto} intc_ip {New AXI SmartConnect} master_apm {0}}  [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD]
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/zynq_ultra_ps_e_0/pl_clk0 (78 MHz)} Clk_slave {/zynq_ultra_ps_e_0/pl_clk0 (78 MHz)} Clk_xbar {/zynq_ultra_ps_e_0/pl_clk0 (78 MHz)} Master {/axi_dma_0/M_AXI_S2MM} Slave {/zynq_ultra_ps_e_0/S_AXI_HP0_FPD} ddr_seg {Auto} intc_ip {/axi_smc} master_apm {0}}  [get_bd_intf_pins axi_dma_0/M_AXI_S2MM]
endgroup
##### Connect Rst to IP #####
startgroup
connect_bd_net [get_bd_pins $myip_instance_name/axi_reset_n] [get_bd_pins rst_ps8_0_78M/peripheral_aresetn]
endgroup




##Add Debug core ILA(Internal Logic Analyzer)
save_bd_design

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0
endgroup
set_property -dict [list CONFIG.C_NUM_MONITOR_SLOTS {4}] [get_bd_cells system_ila_0]

## make sure your IP name is the same to add debug core or you have to add it manually.
set_property HDL_ATTRIBUTE.DEBUG true [get_bd_intf_nets {my_IP_m_axis}] 

set_property HDL_ATTRIBUTE.DEBUG true [get_bd_intf_nets {axi_dma_0_M_AXIS_MM2S}]
set_property HDL_ATTRIBUTE.DEBUG true [get_bd_intf_nets {axi_dma_0_M_AXI_MM2S}]
set_property HDL_ATTRIBUTE.DEBUG true [get_bd_intf_nets {axi_dma_0_M_AXI_S2MM}]

startgroup
apply_bd_automation -rule xilinx.com:bd_rule:debug -dict [list \
                                                          [get_bd_intf_nets axi_dma_0_M_AXI_MM2S] {AXI_R_ADDRESS "Data and Trigger" AXI_R_DATA "Data and Trigger" AXI_W_ADDRESS "None" AXI_W_DATA "None" AXI_W_RESPONSE "None" CLK_SRC "/zynq_ultra_ps_e_0/pl_clk0" SYSTEM_ILA "Auto" APC_EN "0" } \
                                                          [get_bd_intf_nets axi_dma_0_M_AXI_S2MM] {AXI_R_ADDRESS "None" AXI_R_DATA "None" AXI_W_ADDRESS "Data and Trigger" AXI_W_DATA "Data and Trigger" AXI_W_RESPONSE "Data and Trigger" CLK_SRC "/zynq_ultra_ps_e_0/pl_clk0" SYSTEM_ILA "Auto" APC_EN "0" } \
                                                          [get_bd_intf_nets axi_dma_0_M_AXIS_MM2S] {AXIS_SIGNALS "Data and Trigger" CLK_SRC "/zynq_ultra_ps_e_0/pl_clk0" SYSTEM_ILA "Auto" APC_EN "0" } \
                                                          [get_bd_intf_nets my_IP_m_axis] {AXIS_SIGNALS "Data and Trigger" CLK_SRC "/zynq_ultra_ps_e_0/pl_clk0" SYSTEM_ILA "Auto" APC_EN "0" } \
                                                         ]
endgroup





##### Save Desgin #####
save_bd_design
##### validate Desgin #####
validate_bd_design
######## Create HDL Wrapper ##### 
make_wrapper -files [get_files /home/kuanyu/A_zcu104_workplace/$prj_name/$prj_name.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse /home/kuanyu/A_zcu104_workplace/$prj_name/$prj_name.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v

#make_wrapper -files [get_files ${BD_name}.bd] -top
#make_wrapper -files [get_files /home/kuanyu/A_zcu104_workplace/tcb_axis_verilog_out_ip_integraton/tcb_axis_verilog_out_ip_integraton.srcs/sources_1/bd/design_1/design_1.bd] -top

#generate bitstream

launch_runs impl_1 -to_step write_bitstream -jobs 20 -verbose