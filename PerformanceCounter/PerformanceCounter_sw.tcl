#
# performanceCounter_sw.tcl
#

# Create a new software package and name it "altera_ro_zipfs"
create_sw_package performanceCounter

# The version of this software
set_sw_property version 15.0

# Initialize the driver in alt_sys_init()
set_sw_property auto_initialize false

# Location in generated BSP that above sources will be copied into
set_sw_property bsp_subdirectory drivers

#
# Source file listings...
#

# C/C++ source files
add_sw_property c_source performanceCounter.c

# Include files
add_sw_property include_source performanceCounter.h


# This driver supports HAL & UCOSII BSP (OS) types
add_sw_property supported_bsp_type HAL
add_sw_property supported_bsp_type UCOSII

# End of file


