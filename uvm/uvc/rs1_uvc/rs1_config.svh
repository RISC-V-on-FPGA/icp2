//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class rs1_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The rs1 period
    bit[4:0]  rs1;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // rs1 uVC virtual rs1_IF interface.
    virtual rs1_if  m_vif;

    `uvm_object_utils_begin(rs1_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(rs1,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "rs1_config");
        super.new(name);
    endfunction : new

endclass : rs1_config