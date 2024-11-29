//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "immediate_data_config.svh"

class immediate_data_driver extends uvm_driver #(immediate_data_seq_item);
    `uvm_component_utils(immediate_data_driver)

    // immediate_data uVC configuration object.
    immediate_data_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(immediate_data_config)::get(this,"","immediate_data_config", m_config)) begin
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
        immediate_data_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.immediate_data <= m_config.immediate_data;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. immediate_data =%0d", seq_item.immediate_data),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.immediate_data <= seq_item.immediate_data;
                    //m_config.m_vif.immediate_data <= m_config.m_vif.immediate_data; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending immediate_data = %0d", seq_item.immediate_data), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : immediate_data_driver
