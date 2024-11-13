//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class ZeroFlag_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 0;
    // The monitor is active. 
    bit has_monitor = 1;
    // The ZeroFlag period
    bit ZeroFlag;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // ZeroFlag uVC virtual ZeroFlag_IF interface.
    virtual ZeroFlag_if  m_vif;

    `uvm_object_utils_begin(ZeroFlag_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(ZeroFlag,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "ZeroFlag_config");
        super.new(name);
    endfunction : new

endclass : ZeroFlag_config
