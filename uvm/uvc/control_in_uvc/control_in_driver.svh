//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "control_in_config.svh"

class control_in_driver extends uvm_driver #(control_in_seq_item);
    `uvm_component_utils(control_in_driver)

    // control_in uVC configuration object.
    control_in_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(control_in_config)::get(this,"","control_in_config", m_config)) begin
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
        control_in_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.control_in <= m_config.control_in;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. control_in =%0d", seq_item.control_in),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.control_in <= seq_item.control_in;
                    //m_config.m_vif.control_in <= m_config.m_vif.control_in; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending control_in = %0d", seq_item.control_in), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : control_in_driver
