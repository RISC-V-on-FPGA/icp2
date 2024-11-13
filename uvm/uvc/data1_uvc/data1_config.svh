//------------------------------------------------------------------------------
// data1_config class
//
// The configuration of data1.
// This class contains the configuration of data1, and the virtual interface.
//
// The configuration of data1 includes:
//  is_active - indicate whether the sequencer and driver are activated.
//  data1_period - the data1 period.
//
// The virtual interface includes:
//  m_vif - the data1 uVC virtual data1_if interface.
//
//------------------------------------------------------------------------------
class data1_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The data1 period
    logic[31:0]  data1 = 0;
    // data1 uVC virtual data1_IF interface.
    virtual data1_if  m_vif;

    `uvm_object_utils_begin(data1_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(data1,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "data1_config");
        super.new(name);
    endfunction : new

endclass : data1_config
