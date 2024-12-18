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
    logic              [15:0] tb_control_in;
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

    logic              [15:0] tb_control_out;
    logic                     tb_ZeroFlag;
    logic              [31:0] tb_alu_data;
    logic              [31:0] tb_memory_data;
    logic              [4:0]  tb_rd_out;
    logic              [31:0] tb_pc_out;


    // Instantiation of CLOCK uVC interface signal
    clock_if  i_clock_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_clock = i_clock_if.clock;

    // Instantiation of PC uVC interface signal
    pc_if  i_pc_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_pc = i_pc_if.pc;

    // Instantiation of CONTROL_IN uVC interface signal
    control_if  i_control_in_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_control_in = i_control_in_if.control;

    // Instantiation of DATA1 uVC interface signal
    data_if  i_data1_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_data1 = i_data1_if.data;

    // Instantiation of DATA2 uVC interface signal
    data_if  i_data2_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_data2 = i_data2_if.data;

    // Instantiation of IMMEDIATE_DATA uVC interface signal
    data_if  i_immediate_data_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_immediate_data = i_immediate_data_if.data;

    // Instantiation of RD_IN uVC interface signal
    address_if  i_rd_in_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_rd_in = i_rd_in_if.address;

    // Instantiation of RS1 uVC interface signal
    address_if  i_rs1_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_rs1 = i_rs1_if.address;

    // Instantiation of RS2 uVC interface signal
    address_if  i_rs2_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_rs2 = i_rs2_if.address;

    // Instantiation of EX_MEM_RD uVC interface signal
    address_if  i_ex_mem_rd_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_ex_mem_rd = i_ex_mem_rd_if.address;

    // Instantiation of MEM_WB_RD uVC interface signal
    address_if  i_mem_wb_rd_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_mem_wb_rd = i_mem_wb_rd_if.address;

    // Instantiation of EX_MEM_REGWRITE uVC interface signal
    RegWrite_if  i_ex_mem_RegWrite_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_ex_mem_RegWrite = i_ex_mem_RegWrite_if.RegWrite;

    // Instantiation of MEM_WB_REGWRITE uVC interface signal
    RegWrite_if  i_mem_wb_RegWrite_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_mem_wb_RegWrite = i_mem_wb_RegWrite_if.RegWrite;

    // Instantiation of FORWARD_EX_MEM uVC interface signal
    data_if  i_forward_ex_mem_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_forward_ex_mem = i_forward_ex_mem_if.data;
    
    // Instantiation of FORWARD_MEM_WB uVC interface signal
    data_if  i_forward_mem_wb_if(.clk(tb_clock), .rst_n(1'b0));
    assign tb_forward_mem_wb = i_forward_mem_wb_if.data;

    // Instantiation of CONTROL_OUT uVC interface signal
    control_if  i_control_out_if(.clk(tb_clock), .rst_n(1'b0));
    assign i_control_out_if.control = tb_control_out;

    // Instantiation of ZEROFLAG uVC interface signal
    ZeroFlag_if  i_ZeroFlag_if(.clk(tb_clock), .rst_n(1'b0));
    assign i_ZeroFlag_if.ZeroFlag = tb_ZeroFlag;

    // Instantiation of ALU_DATA uVC interface signal
    data_if  i_alu_data_if(.clk(tb_clock), .rst_n(1'b0));
    assign i_alu_data_if.data = tb_alu_data;

    // Instantiation of MEMORY_DATA uVC interface signal
    data_if  i_memory_data_if(.clk(tb_clock), .rst_n(1'b0));
    assign i_memory_data_if.data = tb_memory_data;

    // Instantiation of RD_OUT uVC interface signal
    address_if  i_rd_out_if(.clk(tb_clock), .rst_n(1'b0));
    assign i_rd_out_if.address = tb_rd_out;

    // Instantiation of PC_OUT uVC interface signal
    pc_if  i_pc_out_if(.clk(tb_clock), .rst_n(1'b0));
    assign i_pc_out_if.pc = tb_pc_out;

    // The DUT of doom
    execute_stage execute_stage_dut (
        .clk(tb_clk),
        .pc(tb_pc),
        .control_in(tb_control_in),
        .data1(tb_data1),
        .data2(tb_data2),
        .immediate_data(tb_immediate_data),
        .rd_in(tb_rd_in),
        .rs1(tb_rs1),
        .rs2(tb_rs2),
        .ex_mem_rd(tb_ex_mem_rd),
        .mem_wb_rd(tb_mem_wb_rd),
        .ex_mem_RegWrite(tb_ex_mem_RegWrite),
        .mem_wb_RegWrite(tb_mem_wb_RegWrite),
        .forward_ex_mem(tb_forward_ex_mem),   // Value forwarded from mem stage, better name?
        .forward_mem_wb(tb_forward_mem_wb),   // Value from write back stage

        .control_out(tb_control_out),
        .ZeroFlag(tb_ZeroFlag),
        .alu_data(tb_alu_data),
        .memory_data(tb_memory_data),
        .rd_out(tb_rd_out),
        .pc_out(tb_pc_out)
    );

    // Initialize TB configuration
    initial begin
        top_config m_top_config;
        // Create TB top configuration and store it into UVM config DB.
        m_top_config = new("m_top_config");
        uvm_config_db #(top_config)::set(null,"tb_top","top_config", m_top_config);
        // Save all virtual interface instances into configuration
        m_top_config.m_clock_config.m_vif = i_clock_if;
        m_top_config.m_pc_config.m_vif = i_pc_if;
        m_top_config.m_control_in_config.m_vif = i_control_in_if;
        m_top_config.m_data1_config.m_vif = i_data1_if;
        m_top_config.m_data2_config.m_vif = i_data2_if;
        m_top_config.m_immediate_data_config.m_vif = i_immediate_data_if;
        m_top_config.m_rd_in_config.m_vif = i_rd_in_if;
        m_top_config.m_rs1_config.m_vif = i_rs1_if;
        m_top_config.m_rs2_config.m_vif = i_rs2_if;
        m_top_config.m_ex_mem_rd_config.m_vif = i_ex_mem_rd_if;
        m_top_config.m_mem_wb_rd_config.m_vif = i_mem_wb_rd_if;
        m_top_config.m_ex_mem_RegWrite_config.m_vif = i_ex_mem_RegWrite_if;
        m_top_config.m_mem_wb_RegWrite_config.m_vif = i_mem_wb_RegWrite_if;
        m_top_config.m_forward_ex_mem_config.m_vif = i_forward_ex_mem_if;
        m_top_config.m_forward_mem_wb_config.m_vif = i_forward_mem_wb_if;
        m_top_config.m_control_out_config.m_vif = i_control_out_if;
        m_top_config.m_ZeroFlag_config.m_vif = i_ZeroFlag_if;
        m_top_config.m_alu_data_config.m_vif = i_alu_data_if;
        m_top_config.m_memory_data_config.m_vif = i_memory_data_if;
        m_top_config.m_rd_out_config.m_vif = i_rd_out_if;
        m_top_config.m_pc_out_config.m_vif = i_pc_out_if;
    end

    // Start UVM test_base environment
    initial begin
        run_test("basic_test");
    end

endmodule
