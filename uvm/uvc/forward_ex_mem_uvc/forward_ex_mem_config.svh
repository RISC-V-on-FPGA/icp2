//------------------------------------------------------------------------------
// clock_config class
//
// The configuration of clock.
// This class contains the configuration of clock, and the virtual interface.
//
// The configuration of clock includes:
//  is_active - indicate whether the sequencer and driver are activated.
//  clock_period - the clock period.
//
// The virtual interface includes:
//  m_vif - the clock uVC virtual clock_if interface.
//
//------------------------------------------------------------------------------
class forward_ex_mem_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active=1;

    logic[31:0]  pc = 0;

    virtual pc_if  m_vif;

    `uvm_object_utils_begin(pc_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(pc,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "pc_config");
        super.new(name);
    endfunction : new

endclass : pc_config
