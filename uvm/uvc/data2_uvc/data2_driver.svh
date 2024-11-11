//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class data2_driver extends uvm_driver;
    `uvm_component_utils(data2_driver)

    // data2 uVC configuration object.
    data2_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(data2_config)::get(this,"","data2_config", m_config)) begin
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
        `uvm_info("data2_driver",$sformatf("Start data2 with  %0d", m_config.data2),UVM_MEDIUM)
        // Reset signal
        m_config.m_vif.data2 <= 0;
        // Generate data2
        forever begin
            m_config.m_vif.data2 <= m_config.m_vif.data2;
        end
    endtask : run_phase

endclass : data2_driver
