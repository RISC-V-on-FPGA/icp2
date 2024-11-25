//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "pc_config.svh"

class pc_driver extends uvm_driver #(pc_seq_item);
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
        pc_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.pc <= m_config.pc;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. pc =%0d", seq_item.pc),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.pc <= seq_item.pc;
                    //m_config.m_vif.pc <= m_config.m_vif.pc; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending pc = %0d", seq_item.pc), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : pc_driver
