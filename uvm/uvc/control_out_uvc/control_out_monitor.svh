//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "control_out_config.svh"
// `include "control_out_seq_item.svh"

class control_out_monitor  extends uvm_monitor;
    `uvm_component_param_utils(control_out_monitor)

    // control_out uVC configuration object.
    control_out_config  m_config;
    // Monitor analysis port.
    uvm_analysis_port #(control_out_seq_item)  m_analysis_port;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(control_out_config)::get(this,"","control_out_config", m_config)) begin
            `uvm_fatal(get_name(),"Cannot find the VC configuration!")
        end
        m_analysis_port = new("m_control_out_analysis_port", this);
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

        `uvm_info(get_name(),$sformatf("Starting control_out interface monitoring"),UVM_HIGH)
        forever begin
            // Wait for reset to be released
            `uvm_info(get_name(),$sformatf("Waiting for reset signal is released..."),UVM_HIGH)
            @(posedge m_config.m_vif.rst_n);
            @(negedge m_config.m_vif.clk); // Middle of signal, was commented out ???? (wat)
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
                    control_out_seq_item  seq_item;
                    // Save process info to be able to kill the process
                    check_process = process::self();
                    // Check output data_valid and parallel data
                    forever begin
                        // Sample middle of clk cycle
                        @(negedge m_config.m_vif.clk);
                        // Create a new control_out sequence item with expected data. Here we sample signal to send to scoreboard.
                        `uvm_info(get_name(),$sformatf("Received data valid value=%0d", m_config.m_vif.control_out),UVM_HIGH)
                        seq_item = control_out_seq_item::type_id::create("seq_item");
                        seq_item.control_out = m_config.m_vif.control_out;
                        m_analysis_port.write(seq_item);
                    end
                end
            join_any
        end
    endtask : run_phase
endclass : control_out_monitor
