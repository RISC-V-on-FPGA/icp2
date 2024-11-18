//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "rs2_config.svh"

class rs2_driver extends uvm_driver #(rs2_seq_item);
    `uvm_component_utils(rs2_driver)

    // rs2 uVC configuration object.
    rs2_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(rs2_config)::get(this,"","rs2_config", m_config)) begin
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
        // Perform the requested action and send response back.
        `uvm_info("rs2_driver",$sformatf("Start rs2 with period %0d", m_config.rs2),UVM_MEDIUM)
        // Reset signal
        // sätter OP = ADD -> encoding = I-type -> ALUSrc = 1 för immediate -> MemRead = 0 inte läsa minne -> MemWrite = 0 för inte läsa minne -> RegWrite = 1 vill skriva minne -> MemToreg = 0 -> IsBranch = 0 -> BranchType spelar ingen roll
        m_config.m_vif.rs2 <= 0;              //behövs detta, ger oss NOP instruction???????????????????????????
        // Generate rs2
        rs2_seq_item seq_item;
        forever begin
            seq_item_port.get(seq_item);
            m_config.m_vif.rs2 <= m_config.m_vif.rs2;
        end
    endtask : run_phase

endclass : rs2_driver
