//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "control_out_seq_item.svh"  // Include the item file
// `include "control_out_monitor.svh" 
// `include "control_out_driver.svh" 
// `include "control_out_config.svh" 

class control_out_agent  extends uvm_agent;
    `uvm_component_param_utils(control_out_agent)
    // uVC monitor.
    control_out_monitor m_monitor;
    // uVC configuration object.
    control_out_config m_config;

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
        if (!uvm_config_db #(control_out_config)::get(this,"*","config",m_config)) begin
            `uvm_fatal(get_name(),"Cannot find <config> agent configuration!")
        end
        // Store uVC configuration into UVM config DB used by the uVC.
        uvm_config_db #(control_out_config)::set(this,"*","control_out_config",m_config);
        
        if (m_config.has_monitor) begin
            // Create uVC monitor
            m_monitor = control_out_monitor::type_id::create("control_out_monitor",this);
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
        `uvm_info(get_name(),$sformatf("control_out agent is alive...."), UVM_LOW)
    endfunction : end_of_elaboration_phase
  
endclass: control_out_agent
