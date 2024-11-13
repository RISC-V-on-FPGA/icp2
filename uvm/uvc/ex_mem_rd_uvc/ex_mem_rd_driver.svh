//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "ex_mem_rd_config.svh"

class ex_mem_rd_driver extends uvm_driver;
    `uvm_component_utils(ex_mem_rd_driver)

    // ex_mem_rd uVC configuration object.
    ex_mem_rd_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(ex_mem_rd_config)::get(this,"","ex_mem_rd_config", m_config)) begin
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
        `uvm_info("ex_mem_rd_driver",$sformatf("Start ex_mem_rd with period %0d", m_config.ex_mem_rd),UVM_MEDIUM)
        // Reset signal
        // sätter OP = ADD -> encoding = I-type -> ALUSrc = 1 för immediate -> MemRead = 0 inte läsa minne -> MemWrite = 0 för inte läsa minne -> RegWrite = 1 vill skriva minne -> MemToreg = 0 -> IsBranch = 0 -> BranchType spelar ingen roll
        m_config.m_vif.ex_mem_rd <= 0;              //behövs detta, ger oss NOP instruction???????????????????????????
        // Generate ex_mem_rd
        forever begin
            m_config.m_vif.ex_mem_rd <= m_config.m_vif.ex_mem_rd;
        end
    endtask : run_phase

endclass : ex_mem_rd_driver
