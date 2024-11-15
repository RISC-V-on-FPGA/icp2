//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "pc_config.svh"

class pc_driver extends uvm_driver;
    `uvm_component_utils(pc_driver)

    // pc uVC configuration object.
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
        `uvm_info("pc_driver",$sformatf("Start pc with period %0d", m_config.pc),UVM_MEDIUM)
        // Reset signal
        
        m_config.m_vif.pc <= 0;              //behövs detta, ger oss NOP instruction???????????????????????????
        // Generate pc
        forever begin
            m_config.m_vif.pc <= m_config.m_vif.pc;
        end
    endtask : run_phase

endclass : pc_driver
