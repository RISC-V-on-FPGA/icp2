//------------------------------------------------------------------------------
// forward_mem_wb_agent class
//
// This is the top-level uVC agent for the forward_mem_wb interface.
//
// It reads the uvc configuration from the uvm config database and sets the
// configuration in the uvc driver. It creates the forward_mem_wb driver if the
// configuration is active.
//
//------------------------------------------------------------------------------
class forward_mem_wb_agent  extends uvm_agent;
    `uvm_component_param_utils(forward_mem_wb_agent)

    uvm_seqencer #(forward_mem_wb_seq_item) m_sequencer;
    // uVC driver.
    forward_mem_wb_driver m_driver;
    // uVC configuration object.
    forward_mem_wb_config m_config;
    forward_mem_wb_monitor m_monitor;
    
    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    //------------------------------------------------------------------------------
    // The build phase for the uVC.
    //------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Read the uVC configuration object from UVM config DB.
        if (!uvm_config_db #(forward_mem_wb_config)::get(this,"*","config",m_config)) begin
            `uvm_fatal(get_name(),"Cannot find <config> agent configuration!")
        end
        // Store uVC configuration into UVM config DB used by the uVC.
        uvm_config_db #(forward_mem_wb_config)::set(this,"*","forward_mem_wb_config",m_config);
        if (m_config.is_active == UVM_ACTIVE) begin
            // Create uVC driver
            m_driver = forward_mem_wb_driver::type_id::create("forward_mem_wb_driver",this);
        end
    endfunction : build_phase

    //------------------------------------------------------------------------------
    // The connection phase for the uVC.
    //------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

    //------------------------------------------------------------------------------
    // The end of elaboration phase for the uVC
    //------------------------------------------------------------------------------
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        `uvm_info(get_name(),$sformatf("forward_mem_wb agent is alive...."), UVM_LOW)
    endfunction : end_of_elaboration_phase
  
endclass: forward_mem_wb_agent

