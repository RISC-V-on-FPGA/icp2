//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class rd_in_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The rd_in period
    bit[4:0]  rd_in;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // rd_in uVC virtual rd_in_IF interface.
    virtual rd_in_if m_vif;

    `uvm_object_utils_begin(rd_in_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(rd_in,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "rd_in_config");
        super.new(name);
    endfunction : new

endclass : rd_in_config
