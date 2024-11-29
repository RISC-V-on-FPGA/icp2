//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "RegWrite_config.svh"

class RegWrite_driver extends uvm_driver #(RegWrite_seq_item);
    `uvm_component_utils(RegWrite_driver)

    // RegWrite uVC configuration object.
    RegWrite_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(RegWrite_config)::get(this,"","RegWrite_config", m_config)) begin
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
        RegWrite_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.RegWrite <= m_config.RegWrite;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. RegWrite =%0d", seq_item.RegWrite),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.RegWrite <= seq_item.RegWrite;
                    //m_config.m_vif.RegWrite <= m_config.m_vif.RegWrite; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending RegWrite = %0d", seq_item.RegWrite), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : RegWrite_driver
