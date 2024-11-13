//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class ex_mem_rd_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The ex_mem_rd period
    bit[4:0]  ex_mem_rd;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // ex_mem_rd uVC virtual ex_mem_rd_IF interface.
    virtual ex_mem_rd_if  m_vif;

    `uvm_object_utils_begin(ex_mem_rd_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(ex_mem_rd,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "ex_mem_rd_config");
        super.new(name);
    endfunction : new

endclass : ex_mem_rd_config
