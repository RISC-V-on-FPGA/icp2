//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class pc_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The pc period
    bit[31:0]  pc;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // pc uVC virtual pc_IF interface.
    virtual pc_if m_vif;

    `uvm_object_utils_begin(pc_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(pc,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "pc_config");
        super.new(name);
    endfunction : new

endclass : pc_config
