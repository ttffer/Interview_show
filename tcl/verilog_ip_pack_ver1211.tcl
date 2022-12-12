## Auto pack IP tcl file ver1   creator KY-H 20221127 
## This tcl will pack a verilog file which obeys AXI stream protocol to ../Desktop/vivado4IP 
## Board: zcu 104
## Put verilog file under $hdl_file_location 

#### ip display name
set IP_Display_name "tcbCNN_121_c_25x64x10"
#### ip name
set IP_Name "tcbCNN_121_c_25x64x10_IP"
#### set prj_name
set prj_name "tcbCNN_121_c_25x64x10_prj"
set IP_prj_name "tcbCNN_121_c_25x64x10_prj_ip"
#hdl file location
set hdl_file_location "/home/kuanyu/Desktop/ip_tcl_test"

####
create_project $prj_name -force /home/kuanyu/A_zcu104_workplace/$prj_name -part xczu7ev-ffvc1156-2-e
set_property board_part xilinx.com:zcu104:part0:1.1 [current_project]
add_files -fileset sources_1 -norecurse -scan_for_includes $hdl_file_location
## do not contain tb.v ###
update_compile_order -fileset sources_1


ipx::package_project -root_dir /home/kuanyu/Desktop/vivado4IP/$IP_prj_name -vendor user.org -library user -taxonomy /UserIP -import_files -set_current false -force
ipx::unload_core /home/kuanyu/Desktop/vivado4IP/$IP_prj_name/component.xml
ipx::edit_ip_in_project -upgrade true -name $IP_prj_name -directory /home/kuanyu/Desktop/vivado4IP/$IP_prj_name /home/kuanyu/Desktop/vivado4IP/$IP_prj_name/component.xml


## port mapping ###
##Auto mapping port start
ipx::add_bus_interface m_axis [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:axis_rtl:1.0 [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:axis:1.0 [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]
ipx::add_port_map TDATA [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]
set_property physical_name m_axis_data [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TVALID [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]
set_property physical_name m_axis_valid [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TLAST [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]
set_property physical_name m_axis_last [ipx::get_port_maps TLAST -of_objects [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TREADY [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]
set_property physical_name m_axis_ready [ipx::get_port_maps TREADY -of_objects [ipx::get_bus_interfaces m_axis -of_objects [ipx::current_core]]]
ipx::add_bus_interface s_axis [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:axis_rtl:1.0 [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:axis:1.0 [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]
ipx::add_port_map TDATA [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]
set_property physical_name s_axis_data [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TLAST [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]
set_property physical_name s_axis_last [ipx::get_port_maps TLAST -of_objects [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TVALID [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]
set_property physical_name s_axis_valid [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TREADY [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]
set_property physical_name s_axis_ready [ipx::get_port_maps TREADY -of_objects [ipx::get_bus_interfaces s_axis -of_objects [ipx::current_core]]]
ipx::add_bus_parameter ASSOCIATED_BUSIF [ipx::get_bus_interfaces axi_clk -of_objects [ipx::current_core]]
set_property value m_axis:s_axis [ipx::get_bus_parameters ASSOCIATED_BUSIF -of_objects [ipx::get_bus_interfaces axi_clk -of_objects [ipx::current_core]]]
##Auto mapping port end
set_property name $IP_Name [ipx::current_core]
set_property display_name $IP_Display_name [ipx::current_core]
set_property core_revision 1 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]
##Saving....IP
ipx::save_core [ipx::current_core]
##exit!
exit
