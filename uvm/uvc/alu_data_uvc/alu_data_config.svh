//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class alu_data_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 0;
    // The monitor is active. 
    bit has_monitor = 1;
    // The alu_data period
    bit[31:0]  alu_data;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // alu_data uVC virtual alu_data_IF interface.
    virtual alu_data_if  m_vif;

    `uvm_object_utils_begin(alu_data_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(alu_data,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "alu_data_config");
        super.new(name);
    endfunction : new

endclass : alu_data_config
