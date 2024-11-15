//------------------------------------------------------------------------------
//
// This module is a top-level module for the TB with serial data to parallel  DUT
//
// It instantiates all of the uVC interface instances and connects them to the RTL top.
// It also initializes the UVM test environment and runs the test and
// it creates the default top-level test configuration.
//
// The testbench uses the following uVC interfaces:
// - CLOCK IF: Generates a system clock.
// - RESET IF: Generates the reset signal.
// - SERIAL_DATA IF: Generate parallel data to the DUT input interface
// - PARALLEL_DATA IF: Passes the DUT output infterface to parallel data uVC
//
//------------------------------------------------------------------------------
module tb_top;

    // Include basic packages
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Include optional packages
    import tb_pkg::*;

    // uVC TB signal variables 
    logic                     tb_clock;
    logic              [31:0] tb_pc;
    logic                     tb_control_in;
    logic              [31:0] tb_data1;
    logic              [31:0] tb_data2;
    logic              [31:0] tb_immediate_data;
    logic              [ 4:0] tb_rd_in;
    logic              [ 4:0] tb_rs1;
    logic              [ 4:0] tb_rs2;
    logic              [ 4:0] tb_ex_mem_rd;
    logic              [ 4:0] tb_mem_wb_rd;
    logic                     tb_ex_mem_RegWrite;
    logic                     tb_mem_wb_RegWrite;
    logic              [31:0] tb_forward_ex_mem;   // Value forwarded from mem stage; better name?
    logic              [31:0] tb_forward_mem_wb;   // Value from write back stage

    logic              [31:0] tb_control_out;
    logic                     tb_ZeroFlag;
    logic              [31:0] tb_alu_data;
    logic              [31:0] tb_memory_data;
    logic              [4:0]  tb_rd_out;
    logic              [31:0] tb_pc_out;


    // Instantiation of CLOCK uVC interface signal
    clock_if  i_clock_if();
    assign tb_clock = i_clock_if.clock;

    // Instantiation of PC uVC interface signal
    pc_if  i_pc_if();
    assign tb_pc = i_pc_if.pc;

    // Instantiation of CONTROL_IN uVC interface signal
    control_in_if  i_control_in_if();
    assign tb_control_in = i_control_in_if.control_in;

    // Instantiation of DATA1 uVC interface signal
    data1_if  i_data1_if();
    assign tb_data1 = i_data1_if.data1;

    // Instantiation of DATA2 uVC interface signal
    data2_if  i_data2_if();
    assign tb_data2 = i_data2_if.data2;

    // Instantiation of IMMEDIATE_DATA uVC interface signal
    immediate_data_if  i_immediate_data_if();
    assign tb_immediate_data = i_immediate_data_if.immediate_data;

    // Instantiation of RD_IN uVC interface signal
    rd_in_if  i_rd_in_if();
    assign tb_rd_in = i_rd_in_if.rd_in;

    // Instantiation of RS1 uVC interface signal
    rs1_if  i_rs1_if();
    assign tb_rs1 = i_rs1_if.rs1;

    // Instantiation of RS2 uVC interface signal
    rs2_if  i_rs2_if();
    assign tb_rs2 = i_rs2_if.rs2;

    // Instantiation of EX_MEM_RD uVC interface signal
    ex_mem_rd_if  i_ex_mem_rd_if();
    assign tb_ex_mem_rd = i_ex_mem_rd_if.ex_mem_rd;

    // Instantiation of MEM_WB_RD uVC interface signal
    mem_wb_rd_if  i_mem_wb_rd_if();
    assign tb_mem_wb_rd = i_mem_wb_rd_if.mem_wb_rd;

    // Instantiation of EX_MEM_REGWRITE uVC interface signal
    ex_mem_RegWrite_if  i_ex_mem_RegWrite_if();
    assign tb_ex_mem_RegWrite = i_ex_mem_RegWrite_if.ex_mem_RegWrite;

    // Instantiation of MEM_WB_REGWRITE uVC interface signal
    mem_wb_RegWrite_if  i_mem_wb_RegWrite_if();
    assign tb_mem_wb_RegWrite = i_mem_wb_RegWrite_if.mem_wb_RegWrite;

    // Instantiation of FORWARD_EX_MEM uVC interface signal
    forward_ex_mem_if  i_forward_ex_mem_if();
    assign tb_forward_ex_mem = i_forward_ex_mem_if.forward_ex_mem;
    // Instantiation of FORWARD_MEM_WB uVC interface signal
    forward_mem_wb_if  i_forward_mem_wb_if();
    assign tb_forward_mem_wb = i_forward_mem_wb_if.forward_mem_wb;

    // Instantiation of CONTROL_OUT uVC interface signal
    control_out_if  i_control_out_if();
    assign tb_control_out = i_control_out_if.control_out;

    // Instantiation of ZEROFLAG uVC interface signal
    ZeroFlag_if  i_ZeroFlag_if();
    assign tb_ZeroFlag = i_ZeroFlag_if.ZeroFlag;

    // Instantiation of ALU_DATA uVC interface signal
    alu_data_if  i_alu_data_if();
    assign tb_alu_data = i_alu_data_if.alu_data;

    // Instantiation of MEMORY_DATA uVC interface signal
    memory_data_if  i_memory_data_if();
    assign tb_memory_data = i_memory_data_if.memory_data;

    // Instantiation of RD_OUT uVC interface signal
    rd_out_if  i_rd_out_if();
    assign tb_rd_out = i_rd_out_if.rd_out;

    // Instantiation of PC_OUT uVC interface signal
    pc_out_if  i_pc_out_if();
    assign tb_pc_out = i_pc_out_if.pc_out;


    // Instantiation of the SERIAL_TO_PARALLEL RTL top
    serial_to_parallel serial_to_parallel_dut 
    (
        .clock(tb_clock),
        .reset_n(tb_reset_n),
        .start_bit(tb_start_bit),
        .serial_data(tb_serial_data),
        .parity_enable(tb_parity_enable),
        .data_valid(tb_data_valid),
        .data(tb_data),
        .parity_error(tb_parity_error)
    );



    

    // Initialize TB configuration
    initial begin
        top_config  m_top_config;
        // Create TB top configuration and store it into UVM config DB.
        m_top_config = new("m_top_config");
        uvm_config_db #(top_config)::set(null,"tb_top","top_config", m_top_config);
        // Save all virtual interface instances into configuration
        m_top_config.m_clock_config.m_vif = i_clock_if;
        m_top_config.m_reset_config.m_vif = i_reset_if;
        m_top_config.m_serial_data_config.m_vif = i_serial_data_if;
        m_top_config.m_parallel_data_config.m_vif = i_parallel_data_if;
    end

    // Start UVM test_base environment
    initial begin
        run_test("basic_test");
    end

endmodule
