# TCL File Generated by Component Editor 17.0
# Wed Jun 27 15:57:38 CEST 2018
# DO NOT MODIFY


# 
# PerformanceCounter "PerformanceCounter" v1.0
# David Castells-Rufas 2018.06.27.15:57:38
# A simple Performance 64bit Counter
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module PerformanceCounter
# 
set_module_property DESCRIPTION "A simple Performance 64bit Counter"
set_module_property NAME PerformanceCounter
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Avalon Slave"
set_module_property AUTHOR "David Castells-Rufas"
set_module_property DISPLAY_NAME PerformanceCounter
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL PerformanceCounter
set_fileset_property quartus_synth ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property quartus_synth ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file PerformanceCounter.v VERILOG PATH PerformanceCounter.v TOP_LEVEL_FILE
add_fileset_file performance_Addsub_H872220872_L39.v VERILOG PATH performance_Addsub_H872220872_L39.v
add_fileset_file performance_And2_w1.v VERILOG PATH performance_And2_w1.v
add_fileset_file performance_Constant_w64_v0000000000000001.v VERILOG PATH performance_Constant_w64_v0000000000000001.v
add_fileset_file performance_Gnd_w1.v VERILOG PATH performance_Gnd_w1.v
add_fileset_file performance_Merge_i1486.v VERILOG PATH performance_Merge_i1486.v
add_fileset_file performance_Merge_i1524.v VERILOG PATH performance_Merge_i1524.v
add_fileset_file performance_Not_w1.v VERILOG PATH performance_Not_w1.v
add_fileset_file performance_Or2_w1.v VERILOG PATH performance_Or2_w1.v
add_fileset_file performance_Or3_w1.v VERILOG PATH performance_Or3_w1.v
add_fileset_file performance_REG32LR.v VERILOG PATH performance_REG32LR.v
add_fileset_file performance_Vcc_w1.v VERILOG PATH performance_Vcc_w1.v
add_fileset_file performance_mux_2to1_w32_ws1.v VERILOG PATH performance_mux_2to1_w32_ws1.v
add_fileset_file performance_mux_2to1_w64_ws1.v VERILOG PATH performance_mux_2to1_w64_ws1.v
add_fileset_file performance_upDownCounter_i1546.v VERILOG PATH performance_upDownCounter_i1546.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 readdata readdata Output 32
add_interface_port avalon_slave_0 read read Input 1
add_interface_port avalon_slave_0 address address Input 3
add_interface_port avalon_slave_0 byteenable byteenable Input 4
add_interface_port avalon_slave_0 writedata writedata Input 32
add_interface_port avalon_slave_0 write write Input 1
add_interface_port avalon_slave_0 chipselect chipselect Input 1
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1

