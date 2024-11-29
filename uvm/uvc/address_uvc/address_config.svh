//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class address_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The address period
    bit[4:0]  address;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // address uVC virtual address_IF interface.
    virtual address_if m_vif;

    `uvm_object_utils_begin(address_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(address,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "address_config");
        super.new(name);
    endfunction : new

endclass : address_config
