# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
	set Page0 [ipgui::add_page $IPINST -name "Page 0" -layout vertical]
	set Component_Name [ipgui::add_param $IPINST -parent $Page0 -name Component_Name]
  set DRP_COUNT [ipgui::add_param $IPINST -parent $Page0 -name DRP_COUNT]
	set DRP_ADDR_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name DRP_ADDR_WIDTH]
	set DRP_DATA_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name DRP_DATA_WIDTH]
  set MAX_Value [ipgui::add_dynamic_text $IPINST -name Bar_Value -parent $Page0 -tclproc "update_range" ]
  set NEXT_Offset [ipgui::add_dynamic_text $IPINST -name Bar_Value -parent $Page0 -tclproc "update_next" ]
}

proc {commas} {var {num 3} {char ","}} {
    set len   [string length $var]
    set first [expr $len - $num]
    set x     ""
    while { $len > 0} {
        # grab left num chars
        set lef [string range $var $first end] 
        if {[string length $x] > 0} {
            set x   "${lef}$char${x}"
        } else {
            set x   ${lef}
        }
        # grab everything except left num chars
        set var [string range  $var 0 [expr $first -1]]
        set len   [string length $var]
        set first [expr $len - $num]
    }
    return $x
}

proc update_range { IPINST PARAM_VALUE.DRP_COUNT PARAM_VALUE.DRP_ADDR_WIDTH  } {
  set drps [get_property value ${PARAM_VALUE.DRP_COUNT}] 
  set addr [get_property value ${PARAM_VALUE.DRP_ADDR_WIDTH}] 
  set rawvalue [expr (2**$addr) * 4] 
  set tmpunit " Bytes"
  
  set valuehex [ format 0x%04X $rawvalue ]
  append tmp "Each DRP Interface will occupy " $rawvalue $tmpunit  
  return $tmp;
}

proc update_next { IPINST PARAM_VALUE.DRP_COUNT PARAM_VALUE.DRP_ADDR_WIDTH  } {
  set drps [get_property value ${PARAM_VALUE.DRP_COUNT}] 
  set addr [get_property value ${PARAM_VALUE.DRP_ADDR_WIDTH}] 
  set rawvalue [expr $drps * (2**$addr) * 4] 
  set tmpunit " Bytes"
  
  if { $rawvalue > 1048575} {
    #set rawvalue [expr round( $rawvalue/1048576, 2 ) ]
    #set tmpunit " MB"
  } elseif { $rawvalue > 1023} {
    #set rawvalue [expr round( $rawvalue/1024, 2 ) ]
    #set tmpunit " KB"
  } else {
    #set tmpunit " Byte"
  } 
  set valuehex [ format 0x%04X $rawvalue ]
  append tmp "AXI Range must contain at least " $rawvalue $tmpunit " or (" $valuehex " in hex) of addressable space"
  return $tmp;
}

proc update_PARAM_VALUE.S_AXI_DATA_WIDTH { PARAM_VALUE.S_AXI_DATA_WIDTH } {
	# Procedure called to update S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.S_AXI_DATA_WIDTH { PARAM_VALUE.S_AXI_DATA_WIDTH } {
	# Procedure called to validate S_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.S_AXI_ADDR_WIDTH { PARAM_VALUE.S_AXI_ADDR_WIDTH } {
	# Procedure called to update S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.S_AXI_ADDR_WIDTH { PARAM_VALUE.S_AXI_ADDR_WIDTH } {
	# Procedure called to validate S_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.DRP_DATA_WIDTH { PARAM_VALUE.DRP_DATA_WIDTH } {
	# Procedure called to update DRP_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DRP_DATA_WIDTH { PARAM_VALUE.DRP_DATA_WIDTH } {
	# Procedure called to validate DRP_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DRP_ADDR_WIDTH { PARAM_VALUE.DRP_ADDR_WIDTH } {
	# Procedure called to update DRP_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DRP_ADDR_WIDTH { PARAM_VALUE.DRP_ADDR_WIDTH } {
	# Procedure called to validate DRP_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.DRP_COUNT { PARAM_VALUE.DRP_COUNT } {
	# Procedure called to update DRP_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DRP_COUNT { PARAM_VALUE.DRP_COUNT } {
	# Procedure called to validate DRP_COUNT
	return true
}


proc update_MODELPARAM_VALUE.DRP_COUNT { MODELPARAM_VALUE.DRP_COUNT PARAM_VALUE.DRP_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DRP_COUNT}] ${MODELPARAM_VALUE.DRP_COUNT}
}

proc update_MODELPARAM_VALUE.DRP_ADDR_WIDTH { MODELPARAM_VALUE.DRP_ADDR_WIDTH PARAM_VALUE.DRP_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DRP_ADDR_WIDTH}] ${MODELPARAM_VALUE.DRP_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.DRP_DATA_WIDTH { MODELPARAM_VALUE.DRP_DATA_WIDTH PARAM_VALUE.DRP_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DRP_DATA_WIDTH}] ${MODELPARAM_VALUE.DRP_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.S_AXI_ADDR_WIDTH PARAM_VALUE.S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.S_AXI_DATA_WIDTH { MODELPARAM_VALUE.S_AXI_DATA_WIDTH PARAM_VALUE.S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.S_AXI_DATA_WIDTH}
}

