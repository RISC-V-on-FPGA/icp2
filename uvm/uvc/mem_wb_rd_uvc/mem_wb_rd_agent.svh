//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "mem_wb_rd_seq_item.svh"  // Include the item file
// `include "mem_wb_rd_monitor.svh"
// `include "mem_wb_rd_driver.svh"
// `include "mem_wb_rd_config.svh"

class mem_wb_rd_agent  extends uvm_agent;
    `uvm_component_param_utils(mem_wb_rd_agent)

    // uVC sequencer.
    uvm_sequencer #(mem_wb_rd_seq_item) m_sequencer;
    // uVC monitor.
    mem_wb_rd_monitor m_monitor;
    // uVC driver.
    mem_wb_rd_driver m_driver;
    // uVC configuration object.
    mem_wb_rd_config m_config;

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
        if (!uvm_config_db #(mem_wb_rd_config)::get(this,"*","config",m_config)) begin
            `uvm_fatal(get_name(),"Cannot find <config> agent configuration!")
        end
        // Store uVC configuration into UVM config DB used by the uVC.
        uvm_config_db #(mem_wb_rd_config)::set(this,"*","mem_wb_rd_config",m_config);
        // Store uVC agent into UVM config DB
        if (m_config.is_active == UVM_ACTIVE) begin
            // Create uVC sequencer
            m_sequencer  = uvm_sequencer #(mem_wb_rd_seq_item)::type_id::create("mem_wb_rd_sequencer",this);
            // Create uVC driver
            m_driver = mem_wb_rd_driver::type_id::create("mem_wb_rd_driver",this);
        end
        if (m_config.has_monitor) begin
            // Create uVC monitor
            m_monitor = mem_wb_rd_monitor::type_id::create("mem_wb_rd_monitor",this);
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
        `uvm_info(get_name(),$sformatf("mem_wb_rd agent is alive...."), UVM_LOW)
    endfunction : end_of_elaboration_phase
  
endclass: mem_wb_rd_agent
