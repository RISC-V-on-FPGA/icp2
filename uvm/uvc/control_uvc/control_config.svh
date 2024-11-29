//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class control_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 0;
    // The monitor is active. 
    bit has_monitor = 1;
    // The control period
    bit[15:0]  control;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // control uVC virtual control_IF interface.
    virtual control_if  m_vif;

    `uvm_object_utils_begin(control_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(control,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "control_config");
        super.new(name);
    endfunction : new

endclass : control_config
