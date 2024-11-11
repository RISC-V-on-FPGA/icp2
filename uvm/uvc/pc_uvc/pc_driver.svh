//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class pc_driver extends uvm_driver;
    `uvm_component_utils(pc_driver)

    // CLOCK uVC configuration object.
    pc_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(pc_config)::get(this,"","pc_config", m_config)) begin
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
        `uvm_info("pc_driver",$sformatf("Start pc with  %0d", m_config.pc),UVM_MEDIUM)
        // Reset signal
        m_config.m_vif.pc <= 0;
        // Generate clock
        forever begin
            m_config.m_vif.pc <= m_config.m_vif.pc; // driver takes puts value from sequencer and outputs to the virtual interface 
        end
    endtask : run_phase

endclass : pc_driver
