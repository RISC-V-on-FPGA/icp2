//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class rs2_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The rs2 period
    bit[4:0]  rs2;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // rs2 uVC virtual rs2_IF interface.
    virtual rs2_if  m_vif;

    `uvm_object_utils_begin(rs2_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(rs2,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "rs2_config");
        super.new(name);
    endfunction : new

endclass : rs2_config
