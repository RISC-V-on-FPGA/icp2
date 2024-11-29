//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "address_config.svh"

class address_driver extends uvm_driver #(address_seq_item);
    `uvm_component_utils(address_driver)

    // address uVC configuration object.
    address_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(address_config)::get(this,"","address_config", m_config)) begin
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
        address_seq_item seq_item;        
        // Good to assign start values?????????
        m_config.m_vif.address <= m_config.address;

        forever begin
            // Wait for sequence item
            seq_item_port.get(seq_item);
            `uvm_info(get_name(),$sformatf("Start serial interface transaction. address =%0d", seq_item.address),UVM_HIGH)
            fork
                begin
                    @(posedge m_config.m_vif.clk);
                    m_config.m_vif.address <= seq_item.address;
                    //m_config.m_vif.address <= m_config.m_vif.address; previous statement before changes????
                    `uvm_info(get_name(),$sformatf("Sending address = %0d", seq_item.address), UVM_FULL)
                end
            join
        seq_item_port.put(seq_item);
        end
    endtask : run_phase
endclass : address_driver
