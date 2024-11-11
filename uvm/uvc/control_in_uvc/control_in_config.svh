//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class control_in_config extends uvm_object;

    // The Sequencer and driver are activated
    bit is_active=1;
    // The control_in period
    int control_type  control_in;       //      kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    // control_in uVC virtual control_in_IF interface.
    virtual control_in_if  m_vif;

    `uvm_object_utils_begin(control_in_config)
    `uvm_field_int(is_active,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(control_in_period,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "control_in_config");
        super.new(name);
    endfunction : new

endclass : control_in_config
