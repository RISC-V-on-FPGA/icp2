//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "alu_data_config.svh"
// `include "alu_data_seq_item.svh"

class alu_data_monitor  extends uvm_monitor;
    `uvm_component_param_utils(alu_data_monitor)

    // alu_data uVC configuration object.
    alu_data_config  m_config;
    // Monitor analysis port.
    uvm_analysis_port #(alu_data_seq_item)  m_analysis_port;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(alu_data_config)::get(this,"","alu_data_config", m_config)) begin
            `uvm_fatal(get_name(),"Cannot find the VC configuration!")
        end
        m_analysis_port = new("m_alu_data_analysis_port", this);
    endfunction

    //------------------------------------------------------------------------------
    // The build phase for the component.
    //------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    //------------------------------------------------------------------------------
    // The run phase for the monitor.
    //------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        process check_process;

        `uvm_info(get_name(),$sformatf("Starting alu_data interface monitoring"),UVM_HIGH)
        forever begin
            @(negedge m_config.m_vif.clk); // Middle of signal, was commented out ???? (wat)
            fork
                begin
                    alu_data_seq_item  seq_item;
                    // Save process info to be able to kill the process
                    check_process = process::self();
                    // Check output data_valid and parallel data
                    forever begin
                        // Sample middle of clk cycle
                        @(negedge m_config.m_vif.clk);
                        // Create a new alu_data sequence item with expected data. Here we sample signal to send to scoreboard.
                        `uvm_info(get_name(),$sformatf("Received data valid value=%0d", m_config.m_vif.alu_data),UVM_HIGH)
                        seq_item = alu_data_seq_item::type_id::create("seq_item");
                        seq_item.alu_data = m_config.m_vif.alu_data;
                        m_analysis_port.write(seq_item);
                    end
                end
            join_any
        end
    endtask : run_phase
endclass : alu_data_monitor
