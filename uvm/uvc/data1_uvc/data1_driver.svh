//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class data1_driver extends uvm_driver;
    `uvm_component_utils(data1_driver)

    // data1 uVC configuration object.
    data1_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(data1_config)::get(this,"","data1_config", m_config)) begin
            `uvm_fatal(get_name(),"Cannot find the VC configuration!")
        end
    endfunction

    //------------------------------------------------------------------------------
    // The build phase for the component.
    //------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    //------------------------------------------------------------------------------
    // The run phase for the component.
    //------------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        // Perform the requested action and send response back.
        `uvm_info("data1_driver",$sformatf("Start data1 with  %0d", m_config.data1),UVM_MEDIUM)
        // Reset signal
        m_config.m_vif.data1 <= 0;
        // Generate data1
        forever begin
            m_config.m_vif.data1 <= m_config.m_vif.data1;
        end
    endtask : run_phase

endclass : data1_driver
