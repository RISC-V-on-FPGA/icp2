//------------------------------------------------------------------------------
// data_config class
//
// The configuration of data.
// This class contains the configuration of data, and the virtual interface.
//
// The configuration of data includes:
//  is_active - indicate whether the sequencer and driver are activated.
//  data_period - the data period.
//
// The virtual interface includes:
//  m_vif - the data uVC virtual data_if interface.
//
//------------------------------------------------------------------------------
class data_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active = 1;
    // The monitor is active.
    bit has_monitor = 1;
    // The data period
    logic[31:0]  data = 0;
    // data uVC virtual data_IF interface.
    virtual data_if  m_vif;

    `uvm_object_utils_begin(data_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(data,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(has_monitor,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "data_config");
        super.new(name);
    endfunction : new

endclass : data_config
