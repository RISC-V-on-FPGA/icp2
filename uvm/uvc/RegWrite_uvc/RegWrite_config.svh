//------------------------------------------------------------------------------
// RegWrite_config class
//
// The configuration of RegWrite.
// This class contains the configuration of RegWrite, and the virtual interface.
//
// The configuration of RegWrite includes:
//  is_active - indicate whether the sequencer and driver are activated.
//  RegWrite_period - the RegWrite period.
//
// The virtual interface includes:
//  m_vif - the RegWrite uVC virtual RegWrite_if interface.
//
//------------------------------------------------------------------------------
class RegWrite_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The RegWrite period
    logic  RegWrite = 0;
    // RegWrite uVC virtual RegWrite_IF interface.
    virtual RegWrite_if  m_vif;

    `uvm_object_utils_begin(RegWrite_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(RegWrite,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "RegWrite_config");
        super.new(name);
    endfunction : new

endclass : RegWrite_config
