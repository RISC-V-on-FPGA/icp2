//------------------------------------------------------------------------------
// pc_monitor class
//
// This class is used to monitor the parallel data interface and check its validity.
// It monitors the data_valid and data signals. Before the monitor starts it waits
// for reset is released and every time reset is activated it reset the monitor state.
//
// The class checks if the data_valid signal is asserted, and if so, it creates a new
// pc_seq_item object with the data and parity_error fields filled in.
// The object is then written to the analysis port.
//
//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "pc_config.svh"
// `include "pc_seq_item.svh"

class pc_monitor  extends uvm_monitor;
    `uvm_component_param_utils(pc_monitor)

    // pc uVC configuration object.
    pc_config  m_config;
    // Monitor analysis port.
    uvm_analysis_port #(pc_seq_item)  m_analysis_port;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(pc_config)::get(this,"","pc_config", m_config)) begin
            `uvm_fatal(get_name(),"Cannot find the VC configuration!")
        end
        m_analysis_port = new("m_pc_analysis_port", this);
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

        `uvm_info(get_name(),$sformatf("Starting pc interface monitoring"),UVM_HIGH)
        forever begin
            // Wait for reset to be released
            @(negedge m_config.m_vif.clk); // Middle of signal, was commented ???? (wat)
            `uvm_info(get_name(),$sformatf("Negative Clock Edge DETECTED"),UVM_HIGH)
            fork
                begin
                    pc_seq_item  seq_item;
                    // Save process info to be able to kill the process
                    check_process = process::self();
                    // Check output data_valid and parallel data
                    forever begin
                        // Sample middle of clk cycle
                        @(negedge m_config.m_vif.clk);
                        // Create a new pc sequence item with expected data. Here we sample signal to send to scoreboard.
                        `uvm_info(get_name(),$sformatf("Received data valid value=%0d", m_config.m_vif.pc),UVM_HIGH)
                        seq_item = pc_seq_item::type_id::create("seq_item");
                        seq_item.pc = m_config.m_vif.pc;
                        seq_item.monitor_start_bit_valid = 1; //LÄGGA TILL I ALLA SEN? TODO
                        seq_item.monitor_start_bit_value = 1;
                        seq_item.monitor_data_valid = 1;
                        m_analysis_port.write(seq_item);
                    end
                end
            join_any
        end
    endtask : run_phase
endclass : pc_monitor
