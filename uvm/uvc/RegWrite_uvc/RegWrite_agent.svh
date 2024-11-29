//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "RegWrite_seq_item.svh"  // Include the item file
// `include "RegWrite_monitor.svh"
// `include "RegWrite_driver.svh"
// `include "RegWrite_config.svh"

class RegWrite_agent  extends uvm_agent;
    `uvm_component_param_utils(RegWrite_agent)

    // uVC sequencer.
    uvm_sequencer #(RegWrite_seq_item) m_sequencer;
    // uVC monitor.
    RegWrite_monitor m_monitor;
    // uVC driver.
    RegWrite_driver m_driver;
    // uVC configuration object.
    RegWrite_config m_config;

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
        if (!uvm_config_db #(RegWrite_config)::get(this,"*","config",m_config)) begin
            `uvm_fatal(get_name(),"Cannot find <config> agent configuration!")
        end
        // Store uVC configuration into UVM config DB used by the uVC.
        uvm_config_db #(RegWrite_config)::set(this,"*","RegWrite_config",m_config);
        // Store uVC agent into UVM config DB
        if (m_config.is_active == UVM_ACTIVE) begin
            // Create uVC sequencer
            m_sequencer  = uvm_sequencer #(RegWrite_seq_item)::type_id::create("RegWrite_sequencer",this);
            // Create uVC driver
            m_driver = RegWrite_driver::type_id::create("RegWrite_driver",this);
        end
        if (m_config.has_monitor) begin
            // Create uVC monitor
            m_monitor = RegWrite_monitor::type_id::create("RegWrite_monitor",this);
        end
    endfunction : build_phase

    //------------------------------------------------------------------------------
    // The connection phase for the uVC.
    //------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // If driver active connect then sequencer to the driver.
        if (m_config.is_active == UVM_ACTIVE) begin
            m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        end
    endfunction : connect_phase

    //------------------------------------------------------------------------------
    // The end of elaboration phase for the uVC
    //------------------------------------------------------------------------------
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        `uvm_info(get_name(),$sformatf("RegWrite agent is alive...."), UVM_LOW)
    endfunction : end_of_elaboration_phase
  
endclass: RegWrite_agent
