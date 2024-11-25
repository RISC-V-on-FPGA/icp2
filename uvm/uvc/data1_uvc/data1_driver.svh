//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "data1_config.svh"

class data1_driver extends uvm_driver #(data1_seq_item);
    `uvm_component_utils(data1_driver)

    // data1 uVC configuration object.
    data1_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(data1_config)::get(this,"","data1_config", m_config)) begin
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
        data1_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.data1 <= m_config.data1;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. data1 =%0d", seq_item.data1),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.data1 <= seq_item.data1;
                    //m_config.m_vif.data1 <= m_config.m_vif.data1; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending data1 = %0d", seq_item.data1), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : data1_driver
