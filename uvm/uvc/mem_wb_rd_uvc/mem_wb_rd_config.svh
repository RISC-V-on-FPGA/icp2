//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class mem_wb_rd_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The mem_wb_rd period
    bit[4:0]  mem_wb_rd;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // mem_wb_rd uVC virtual mem_wb_rd_IF interface.
    virtual mem_wb_rd_if  m_vif;

    `uvm_object_utils_begin(mem_wb_rd_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(mem_wb_rd,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "mem_wb_rd_config");
        super.new(name);
    endfunction : new

endclass : mem_wb_rd_config
