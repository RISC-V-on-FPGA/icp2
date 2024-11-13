//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "mem_wb_rd_config.svh"

class mem_wb_rd_driver extends uvm_driver;
    `uvm_component_utils(mem_wb_rd_driver)

    // mem_wb_rd uVC configuration object.
    mem_wb_rd_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(mem_wb_rd_config)::get(this,"","mem_wb_rd_config", m_config)) begin
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
        `uvm_info("mem_wb_rd_driver",$sformatf("Start mem_wb_rd with period %0d", m_config.mem_wb_rd),UVM_MEDIUM)
        // Reset signal
        // sätter OP = ADD -> encoding = I-type -> ALUSrc = 1 för immediate -> MemRead = 0 inte läsa minne -> MemWrite = 0 för inte läsa minne -> RegWrite = 1 vill skriva minne -> MemToreg = 0 -> IsBranch = 0 -> BranchType spelar ingen roll
        m_config.m_vif.mem_wb_rd <= 0;              //behövs detta, ger oss NOP instruction???????????????????????????
        // Generate mem_wb_rd
        forever begin
            m_config.m_vif.mem_wb_rd <= m_config.m_vif.mem_wb_rd;
        end
    endtask : run_phase

endclass : mem_wb_rd_driver
