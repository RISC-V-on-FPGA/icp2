//------------------------------------------------------------------------------
// rs2_monitor class
//
// This class is used to monitor the parallel data interface and check its validity.
// It monitors the data_valid and data signals. Before the monitor starts it waits
// for reset is released and every time reset is activated it reset the monitor state.
//
// The class checks if the data_valid signal is asserted, and if so, it creates a new
// rs2_seq_item object with the data and parity_error fields filled in.
// The object is then written to the analysis port.
//
//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "rs2_config.svh"
// `include "rs2_seq_item.svh"

class rs2_monitor  extends uvm_monitor;
    `uvm_component_param_utils(rs2_monitor)

    // rs2 uVC configuration object.
    rs2_config  m_config;
    // Monitor analysis port.
    uvm_analysis_port #(rs2_seq_item)  m_analysis_port;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(rs2_config)::get(this,"","rs2_config", m_config)) begin
            `uvm_fatal(get_name(),"Cannot find the VC configuration!")
        end
        m_analysis_port = new("m_rs2_analysis_port", this);
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

        `uvm_info(get_name(),$sformatf("Starting rs2 interface monitoring"),UVM_HIGH)
        forever begin
            // Wait for reset to be released
            `uvm_info(get_name(),$sformatf("Waiting for reset signal is released..."),UVM_HIGH)
            @(posedge m_config.m_vif.rst_n);
            @(negedge m_config.m_vif.clk); // Middle of signal, was commented ???? (wat)
            `uvm_info(get_name(),$sformatf("Reset signal is released"),UVM_HIGH)
            fork
                // Detect reset during testing
                begin
                    @(negedge m_config.m_vif.rst_n);
                    `uvm_info(get_name(),$sformatf("Reset detected. Checking aborted!!"),UVM_HIGH)
                    if (check_process != null) begin
                        check_process.kill();
                    end
                end
                begin
                    rs2_seq_item  seq_item;
                    // Save process info to be able to kill the process
                    check_process = process::self();
                    // Check output data_valid and parallel data
                    forever begin
                        // Sample middle of clk cycle
                        @(negedge m_config.m_vif.clk);
                        // Create a new rs2 sequence item with expected data. Here we sample signal to send to scoreboard.
                        `uvm_info(get_name(),$sformatf("Received data valid value=%0d", m_config.m_vif.rs2),UVM_HIGH)
                        seq_item = rs2_seq_item::type_id::create("seq_item");
                        seq_item.rs2 = m_config.m_vif.rs2;
                        m_analysis_port.write(seq_item);
                    end
                end
            join_any
        end
    endtask : run_phase
endclass : rs2_monitor
