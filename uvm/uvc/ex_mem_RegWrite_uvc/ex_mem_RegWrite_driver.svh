//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "ex_mem_RegWrite_config.svh"

class ex_mem_RegWrite_driver extends uvm_driver #(ex_mem_RegWrite_seq_item);
    `uvm_component_utils(ex_mem_RegWrite_driver)

    // ex_mem_RegWrite uVC configuration object.
    ex_mem_RegWrite_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(ex_mem_RegWrite_config)::get(this,"","ex_mem_RegWrite_config", m_config)) begin
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
        ex_mem_RegWrite_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.ex_mem_RegWrite <= m_config.ex_mem_RegWrite;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. ex_mem_RegWrite =%0d", seq_item.ex_mem_RegWrite),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.ex_mem_RegWrite <= seq_item.ex_mem_RegWrite;
                    //m_config.m_vif.ex_mem_RegWrite <= m_config.m_vif.ex_mem_RegWrite; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending ex_mem_RegWrite = %0d", seq_item.ex_mem_RegWrite), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : ex_mem_RegWrite_driver
