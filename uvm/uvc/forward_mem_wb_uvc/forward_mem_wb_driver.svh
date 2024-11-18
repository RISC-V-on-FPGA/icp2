//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class forward_mem_wb_driver extends uvm_driver;
    `uvm_component_utils(forward_mem_wb_driver)

    // forward_mem_wb uVC configuration object.
    forward_mem_wb_config m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(forward_mem_wb_config)::get(this,"","forward_mem_wb_config", m_config)) begin
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
        `uvm_info("forward_mem_wb_driver",$sformatf("Start forward_mem_wb with  %0d", m_config.forward_mem_wb),UVM_MEDIUM)
        // Reset signal
        m_config.m_vif.forward_mem_wb <= 0;
        // Generate clock
        forever begin
            m_config.m_vif.forward_mem_wb <= m_config.m_vif.forward_mem_wb; // driver puts value from sequencer and outputs to the virtual interface 
        end
    endtask : run_phase

endclass : forward_mem_wb_driver
