//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "forward_ex_mem_config.svh"

class forward_ex_mem_driver extends uvm_driver #(forward_ex_mem_seq_item);
    `uvm_component_utils(forward_ex_mem_driver)

    // forward_ex_mem uVC configuration object.
    forward_ex_mem_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(forward_ex_mem_config)::get(this,"","forward_ex_mem_config", m_config)) begin
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
        forward_ex_mem_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.forward_ex_mem <= m_config.forward_ex_mem;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. forward_ex_mem =%0d", seq_item.forward_ex_mem),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.forward_ex_mem <= seq_item.forward_ex_mem;
                    //m_config.m_vif.forward_ex_mem <= m_config.m_vif.forward_ex_mem; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending forward_ex_mem = %0d", seq_item.forward_ex_mem), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : forward_ex_mem_driver
