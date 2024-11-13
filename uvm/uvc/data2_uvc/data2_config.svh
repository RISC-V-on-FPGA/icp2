//------------------------------------------------------------------------------
// data2_config class
//
// The configuration of data2.
// This class contains the configuration of data2, and the virtual interface.
//
// The configuration of data2 includes:
//  is_active - indicate whether the sequencer and driver are activated.
//  data2_period - the data2 period.
//
// The virtual interface includes:
//  m_vif - the data2 uVC virtual data2_if interface.
//
//------------------------------------------------------------------------------
class data2_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The data2 period
    logic[31:0]  data2 = 0;
    // data2 uVC virtual data2_IF interface.
    virtual data2_if  m_vif;

    `uvm_object_utils_begin(data2_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(data2,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "data2_config");
        super.new(name);
    endfunction : new

endclass : data2_config
