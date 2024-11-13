//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "ZeroFlag_seq_item.svh"  // Include the item file
// `include "ZeroFlag_monitor.svh" 
// `include "ZeroFlag_driver.svh" 
// `include "ZeroFlag_config.svh" 

class ZeroFlag_agent  extends uvm_agent;
    `uvm_component_param_utils(ZeroFlag_agent)
    // uVC monitor.
    ZeroFlag_monitor m_monitor;
    // uVC configuration object.
    ZeroFlag_config m_config;

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
        if (!uvm_config_db #(ZeroFlag_config)::get(this,"*","config",m_config)) begin
            `uvm_fatal(get_name(),"Cannot find <config> agent configuration!")
        end
        // Store uVC configuration into UVM config DB used by the uVC.
        uvm_config_db #(ZeroFlag_config)::set(this,"*","ZeroFlag_config",m_config);
        
        if (m_config.has_monitor) begin
            // Create uVC monitor
            m_monitor = ZeroFlag_monitor::type_id::create("ZeroFlag_monitor",this);
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
        `uvm_info(get_name(),$sformatf("ZeroFlag agent is alive...."), UVM_LOW)
    endfunction : end_of_elaboration_phase
  
endclass: ZeroFlag_agent
