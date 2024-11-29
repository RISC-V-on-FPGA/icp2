//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "mem_wb_rd_config.svh"

class mem_wb_rd_driver extends uvm_driver #(mem_wb_rd_seq_item);
    `uvm_component_utils(mem_wb_rd_driver)

    // mem_wb_rd uVC configuration object.
    mem_wb_rd_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(mem_wb_rd_config)::get(this,"","mem_wb_rd_config", m_config)) begin
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
        mem_wb_rd_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.mem_wb_rd <= m_config.mem_wb_rd;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. mem_wb_rd =%0d", seq_item.mem_wb_rd),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.mem_wb_rd <= seq_item.mem_wb_rd;
                    //m_config.m_vif.mem_wb_rd <= m_config.m_vif.mem_wb_rd; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending mem_wb_rd = %0d", seq_item.mem_wb_rd), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : mem_wb_rd_driver
