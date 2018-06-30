#
# vga_controller_sw.tcl
#

# Create a new software package
create_driver vga_controller_driver

set_sw_property hw_class_name vga_controller

# The version of this software
set_sw_property version 7.1

# Initialize the driver in alt_sys_init()
set_sw_property auto_initialize true

# Location in generated BSP that above sources will be copied into
set_sw_property bsp_subdirectory drivers

#
# Source file listings...
#

# C/C++ source files
add_sw_property c_source HAL/src/vga_controller.c

# Include files
add_sw_property include_source HAL/inc/vga_controller.h


# This driver supports HAL & UCOSII BSP (OS) types
add_sw_property supported_bsp_type HAL
add_sw_property supported_bsp_type UCOSII

# End of file


