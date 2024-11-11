//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class immediate_data_driver extends uvm_driver;
    `uvm_component_utils(immediate_data_driver)

    // immediate_data uVC configuration object.
    immediate_data_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(immediate_data_config)::get(this,"","immediate_data_config", m_config)) begin
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
        `uvm_info("immediate_data_driver",$sformatf("Start immediate_data with  %0d", m_config.immediate_data),UVM_MEDIUM)
        // Reset signal
        m_config.m_vif.immediate_data <= 0;
        // Generate immediate_data
        forever begin
            m_config.m_vif.immediate_data <= m_config.m_vif.immediate_data;
        end
    endtask : run_phase

endclass : immediate_data_driver
