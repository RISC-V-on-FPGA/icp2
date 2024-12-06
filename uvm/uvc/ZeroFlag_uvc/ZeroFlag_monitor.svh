//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "ZeroFlag_config.svh"
// `include "ZeroFlag_seq_item.svh"

class ZeroFlag_monitor  extends uvm_monitor;
    `uvm_component_param_utils(ZeroFlag_monitor)

    // ZeroFlag uVC configuration object.
    ZeroFlag_config  m_config;
    // Monitor analysis port.
    uvm_analysis_port #(ZeroFlag_seq_item)  m_analysis_port;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(ZeroFlag_config)::get(this,"","ZeroFlag_config", m_config)) begin
            `uvm_fatal(get_name(),"Cannot find the VC configuration!")
        end
        m_analysis_port = new("m_ZeroFlag_analysis_port", this);
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

        `uvm_info(get_name(),$sformatf("Starting ZeroFlag interface monitoring"),UVM_HIGH)
        forever begin
            //@(negedge m_config.m_vif.clk); // Middle of signal, was commented out ???? (wat)
            fork
                begin
                    ZeroFlag_seq_item  seq_item;
                    // Save process info to be able to kill the process
                    check_process = process::self();
                    // Check output data_valid and parallel data
                    forever begin
                        // Sample middle of clk cycle
                        @(posedge m_config.m_vif.clk);
                        // Create a new ZeroFlag sequence item with expected data. Here we sample signal to send to scoreboard.
                        `uvm_info(get_name(),$sformatf("Received data valid value=%0d", m_config.m_vif.ZeroFlag),UVM_HIGH)
                        seq_item = ZeroFlag_seq_item::type_id::create("seq_item");
                        seq_item.ZeroFlag = m_config.m_vif.ZeroFlag;
                        m_analysis_port.write(seq_item);
                    end
                end
            join_any
        end
    endtask : run_phase
endclass : ZeroFlag_monitor
