//------------------------------------------------------------------------------
// mem_wb_RegWrite_config class
//
// The configuration of mem_wb_RegWrite.
// This class contains the configuration of mem_wb_RegWrite, and the virtual interface.
//
// The configuration of mem_wb_RegWrite includes:
//  is_active - indicate whether the sequencer and driver are activated.
//  mem_wb_RegWrite_period - the mem_wb_RegWrite period.
//
// The virtual interface includes:
//  m_vif - the mem_wb_RegWrite uVC virtual mem_wb_RegWrite_if interface.
//
//------------------------------------------------------------------------------
class mem_wb_RegWrite_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The mem_wb_RegWrite period
    logic  mem_wb_RegWrite = 0;
    // mem_wb_RegWrite uVC virtual mem_wb_RegWrite_IF interface.
    virtual mem_wb_RegWrite_if  m_vif;

    `uvm_object_utils_begin(mem_wb_RegWrite_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(mem_wb_RegWrite,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "mem_wb_RegWrite_config");
        super.new(name);
    endfunction : new

endclass : mem_wb_RegWrite_config
