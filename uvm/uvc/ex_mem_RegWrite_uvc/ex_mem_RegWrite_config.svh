//------------------------------------------------------------------------------
// ex_mem_RegWrite_config class
//
// The configuration of ex_mem_RegWrite.
// This class contains the configuration of ex_mem_RegWrite, and the virtual interface.
//
// The configuration of ex_mem_RegWrite includes:
//  is_active - indicate whether the sequencer and driver are activated.
//  ex_mem_RegWrite_period - the ex_mem_RegWrite period.
//
// The virtual interface includes:
//  m_vif - the ex_mem_RegWrite uVC virtual ex_mem_RegWrite_if interface.
//
//------------------------------------------------------------------------------
class ex_mem_RegWrite_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The ex_mem_RegWrite period
    logic  ex_mem_RegWrite = 0;
    // ex_mem_RegWrite uVC virtual ex_mem_RegWrite_IF interface.
    virtual ex_mem_RegWrite_if  m_vif;

    `uvm_object_utils_begin(ex_mem_RegWrite_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(ex_mem_RegWrite,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "ex_mem_RegWrite_config");
        super.new(name);
    endfunction : new

endclass : ex_mem_RegWrite_config
