# TCL File Generated by Component Editor 17.0
# Sun Jul 01 07:18:40 CEST 2018
# DO NOT MODIFY


# 
# vga_controller "vga_controller" v7.1
# David Castells-Rufas 2018.07.01.07:18:40
# VGA Controller
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module vga_controller
# 
set_module_property DESCRIPTION "VGA Controller"
set_module_property NAME vga_controller
set_module_property VERSION 7.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Avalon Slave"
set_module_property AUTHOR "David Castells-Rufas"
set_module_property DISPLAY_NAME vga_controller
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL vga_controller
set_fileset_property quartus_synth ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property quartus_synth ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file vga_controller.v VERILOG PATH vga_controller.v TOP_LEVEL_FILE
add_fileset_file vga_sync.v VERILOG PATH vga_sync.v
add_fileset_file vga_registers.v VERILOG PATH vga_registers.v


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

add_interface_port reset reset_n reset_n Input 1


# 
# connection point vga_conduit
# 
add_interface vga_conduit conduit end
set_interface_property vga_conduit associatedClock clock
set_interface_property vga_conduit associatedReset ""
set_interface_property vga_conduit ENABLED true
set_interface_property vga_conduit EXPORT_OF ""
set_interface_property vga_conduit PORT_NAME_MAP ""
set_interface_property vga_conduit CMSIS_SVD_VARIABLES ""
set_interface_property vga_conduit SVD_ADDRESS_GROUP ""

add_interface_port vga_conduit sync_n sync_n Output 1
add_interface_port vga_conduit sync_t sync_t Output 1
add_interface_port vga_conduit hsync hsync Output 1
add_interface_port vga_conduit B b Output 8
add_interface_port vga_conduit G g Output 8
add_interface_port vga_conduit vsync vsync Output 1
add_interface_port vga_conduit R r Output 8
add_interface_port vga_conduit blank_n blank_n Output 1


# 
# connection point fb_fetcher
# 
add_interface fb_fetcher avalon start
set_interface_property fb_fetcher addressUnits SYMBOLS
set_interface_property fb_fetcher associatedClock clock
set_interface_property fb_fetcher associatedReset reset
set_interface_property fb_fetcher bitsPerSymbol 8
set_interface_property fb_fetcher burstOnBurstBoundariesOnly false
set_interface_property fb_fetcher burstcountUnits WORDS
set_interface_property fb_fetcher doStreamReads false
set_interface_property fb_fetcher doStreamWrites false
set_interface_property fb_fetcher holdTime 0
set_interface_property fb_fetcher linewrapBursts false
set_interface_property fb_fetcher maximumPendingReadTransactions 0
set_interface_property fb_fetcher maximumPendingWriteTransactions 0
set_interface_property fb_fetcher readLatency 0
set_interface_property fb_fetcher readWaitTime 1
set_interface_property fb_fetcher setupTime 0
set_interface_property fb_fetcher timingUnits Cycles
set_interface_property fb_fetcher writeWaitTime 0
set_interface_property fb_fetcher ENABLED true
set_interface_property fb_fetcher EXPORT_OF ""
set_interface_property fb_fetcher PORT_NAME_MAP ""
set_interface_property fb_fetcher CMSIS_SVD_VARIABLES ""
set_interface_property fb_fetcher SVD_ADDRESS_GROUP ""

add_interface_port fb_fetcher master_data_valid readdatavalid Input 1
add_interface_port fb_fetcher master_readdata readdata Input 32
add_interface_port fb_fetcher master_waitrequest waitrequest Input 1
add_interface_port fb_fetcher master_address address Output 32
add_interface_port fb_fetcher master_read read Output 1


# 
# connection point control
# 
add_interface control avalon end
set_interface_property control addressUnits WORDS
set_interface_property control associatedClock clock
set_interface_property control associatedReset reset
set_interface_property control bitsPerSymbol 8
set_interface_property control burstOnBurstBoundariesOnly false
set_interface_property control burstcountUnits WORDS
set_interface_property control explicitAddressSpan 0
set_interface_property control holdTime 0
set_interface_property control linewrapBursts false
set_interface_property control maximumPendingReadTransactions 0
set_interface_property control maximumPendingWriteTransactions 0
set_interface_property control readLatency 0
set_interface_property control readWaitTime 1
set_interface_property control setupTime 0
set_interface_property control timingUnits Cycles
set_interface_property control writeWaitTime 0
set_interface_property control ENABLED true
set_interface_property control EXPORT_OF ""
set_interface_property control PORT_NAME_MAP ""
set_interface_property control CMSIS_SVD_VARIABLES ""
set_interface_property control SVD_ADDRESS_GROUP ""

add_interface_port control slave_address address Input 2
add_interface_port control slave_chipselect chipselect Input 1
add_interface_port control slave_write write Input 1
add_interface_port control slave_writedata writedata Input 32
add_interface_port control slave_readdata readdata Output 32
set_interface_assignment control embeddedsw.configuration.isFlash 0
set_interface_assignment control embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment control embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment control embeddedsw.configuration.isPrintableDevice 0


# 
# connection point vga_clk
# 
add_interface vga_clk clock end
set_interface_property vga_clk clockRate 0
set_interface_property vga_clk ENABLED true
set_interface_property vga_clk EXPORT_OF ""
set_interface_property vga_clk PORT_NAME_MAP ""
set_interface_property vga_clk CMSIS_SVD_VARIABLES ""
set_interface_property vga_clk SVD_ADDRESS_GROUP ""

add_interface_port vga_clk vga_clk clk Input 1

