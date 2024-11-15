//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class immediate_data_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The immediate_data period
    bit[31:0]  immediate_data;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // immediate_data uVC virtual immediate_data_IF interface.
    virtual immediate_data_if  m_vif;

    `uvm_object_utils_begin(immediate_data_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(immediate_data,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "immediate_data_config");
        super.new(name);
    endfunction : new

endclass : immediate_data_config
