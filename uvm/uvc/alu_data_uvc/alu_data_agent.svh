//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "alu_data_seq_item.svh"  // Include the item file
// `include "alu_data_monitor.svh" 
// `include "alu_data_driver.svh" 
// `include "alu_data_config.svh" 

class alu_data_agent  extends uvm_agent;
    `uvm_component_param_utils(alu_data_agent)
    // uVC monitor.
    alu_data_monitor m_monitor;
    // uVC configuration object.
    alu_data_config m_config;

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
        if (!uvm_config_db #(alu_data_config)::get(this,"*","config",m_config)) begin
            `uvm_fatal(get_name(),"Cannot find <config> agent configuration!")
        end
        // Store uVC configuration into UVM config DB used by the uVC.
        uvm_config_db #(alu_data_config)::set(this,"*","alu_data_config",m_config);
        
        if (m_config.has_monitor) begin
            // Create uVC monitor
            m_monitor = alu_data_monitor::type_id::create("alu_data_monitor",this);
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
        `uvm_info(get_name(),$sformatf("alu_data agent is alive...."), UVM_LOW)
    endfunction : end_of_elaboration_phase
  
endclass: alu_data_agent
