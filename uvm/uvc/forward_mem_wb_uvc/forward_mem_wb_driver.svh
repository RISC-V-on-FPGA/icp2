//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "forward_mem_wb_config.svh"

class forward_mem_wb_driver extends uvm_driver #(forward_mem_wb_seq_item);
    `uvm_component_utils(forward_mem_wb_driver)

    // forward_mem_wb uVC configuration object.
    forward_mem_wb_config  m_config;

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
        forward_mem_wb_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.forward_mem_wb <= m_config.forward_mem_wb;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. forward_mem_wb =%0d", seq_item.forward_mem_wb),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.forward_mem_wb <= seq_item.forward_mem_wb;
                    //m_config.m_vif.forward_mem_wb <= m_config.m_vif.forward_mem_wb; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending forward_mem_wb = %0d", seq_item.forward_mem_wb), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : forward_mem_wb_driver
