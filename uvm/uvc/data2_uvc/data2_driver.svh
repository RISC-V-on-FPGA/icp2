//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "data2_config.svh"

class data2_driver extends uvm_driver #(data2_seq_item);
    `uvm_component_utils(data2_driver)

    // data2 uVC configuration object.
    data2_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(data2_config)::get(this,"","data2_config", m_config)) begin
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
        data2_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.data2 <= m_config.data2;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. data2 =%0d", seq_item.data2),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.data2 <= seq_item.data2;
                    //m_config.m_vif.data2 <= m_config.m_vif.data2; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending data2 = %0d", seq_item.data2), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : data2_driver
