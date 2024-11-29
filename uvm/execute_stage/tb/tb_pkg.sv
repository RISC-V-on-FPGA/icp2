//------------------------------------------------------------------------------
// Testbench package.
//
// The tb_pkg package provides a collection of files and
// uVCs that are used for testbench development
//
// The package also imports the UVM package and includes
// the necessary UVM macros to support UVM-based testbenches
//
//------------------------------------------------------------------------------
`timescale 1ns/1ns
package tb_pkg;
    // Import from UVM package
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Include files from the alu_data uVC
    `include "alu_data_seq_item.svh"
    `include "alu_data_config.svh"
    //`include "alu_data_driver.svh"
    `include "alu_data_monitor.svh"
    `include "alu_data_agent.svh"

    // Include files from the clock uVC
    `include "clock_config.svh"
    `include "clock_driver.svh"
    `include "clock_agent.svh"

    // Include files from the control_in uVC
    `include "control_in_seq_item.svh"
    `include "control_in_seq.svh"
    `include "control_in_config.svh"
    `include "control_in_driver.svh"
    `include "control_in_monitor.svh"
    `include "control_in_agent.svh"

    // Include files from the control_out uVC
    `include "control_out_seq_item.svh"
    `include "control_out_config.svh"
    //`include "control_out_driver.svh"
    `include "control_out_monitor.svh"
    `include "control_out_agent.svh"

    // Include files from the data1 uVC
    `include "data1_seq_item.svh"
    `include "data1_seq.svh"
    `include "data1_config.svh"
    `include "data1_driver.svh"
    `include "data1_monitor.svh"
    `include "data1_agent.svh"

    // Include files from the data2 uVC
    `include "data2_seq_item.svh"
    `include "data2_seq.svh"
    `include "data2_config.svh"
    `include "data2_driver.svh"
    `include "data2_monitor.svh"
    `include "data2_agent.svh"

    // Include files from the ex_mem_rd uVC
    `include "ex_mem_rd_seq_item.svh"
    `include "ex_mem_rd_seq.svh"
    `include "ex_mem_rd_config.svh"
    `include "ex_mem_rd_driver.svh"
    `include "ex_mem_rd_monitor.svh"
    `include "ex_mem_rd_agent.svh"

    // Include files from the ex_mem_RegWrite uVC
    `include "ex_mem_RegWrite_seq_item.svh"
    `include "ex_mem_RegWrite_seq.svh"
    `include "ex_mem_RegWrite_config.svh"
    `include "ex_mem_RegWrite_driver.svh"
    `include "ex_mem_RegWrite_monitor.svh"
    `include "ex_mem_RegWrite_agent.svh"

    // Include files from the forward_ex_mem uVC
    `include "forward_ex_mem_seq_item.svh"
    `include "forward_ex_mem_seq.svh"
    `include "forward_ex_mem_config.svh"
    `include "forward_ex_mem_driver.svh"
    `include "forward_ex_mem_monitor.svh"
    `include "forward_ex_mem_agent.svh"

    // Include files from the forward_mem_wb uVC
    `include "forward_mem_wb_seq_item.svh"
    `include "forward_mem_wb_seq.svh"
    `include "forward_mem_wb_config.svh"
    `include "forward_mem_wb_driver.svh"
    `include "forward_mem_wb_monitor.svh"
    `include "forward_mem_wb_agent.svh"

    // Include files from the immediate_data uVC
    `include "immediate_data_seq_item.svh"
    `include "immediate_data_seq.svh"
    `include "immediate_data_config.svh"
    `include "immediate_data_driver.svh"
    `include "immediate_data_monitor.svh"
    `include "immediate_data_agent.svh"

    // Include files from the mem_wb_rd uVC
    `include "mem_wb_rd_seq_item.svh"
    `include "mem_wb_rd_seq.svh"
    `include "mem_wb_rd_config.svh"
    `include "mem_wb_rd_driver.svh"
    `include "mem_wb_rd_monitor.svh"
    `include "mem_wb_rd_agent.svh"

    // Include files from the mem_wb_RegWrite uVC
    `include "mem_wb_RegWrite_seq_item.svh"
    `include "mem_wb_RegWrite_seq.svh"
    `include "mem_wb_RegWrite_config.svh"
    `include "mem_wb_RegWrite_driver.svh"
    `include "mem_wb_RegWrite_monitor.svh"
    `include "mem_wb_RegWrite_agent.svh"

    // Include files from the memory_data uVC
    `include "memory_data_seq_item.svh"
    `include "memory_data_config.svh"
    //`include "memory_data_driver.svh"
    `include "memory_data_monitor.svh"
    `include "memory_data_agent.svh"

    // Include files from the pc_out uVC
    `include "pc_out_seq_item.svh"
    `include "pc_out_config.svh"
    //`include "pc_out_driver.svh"
    `include "pc_out_monitor.svh"
    `include "pc_out_agent.svh"

    // Include files from the pc uVC
    `include "pc_seq_item.svh"
    `include "pc_seq.svh"
    `include "pc_config.svh"
    `include "pc_driver.svh"
    `include "pc_monitor.svh"
    `include "pc_agent.svh"

    // Include files from the rd_in uVC
    `include "rd_in_seq_item.svh"
    `include "rd_in_seq.svh"
    `include "rd_in_config.svh"
    `include "rd_in_driver.svh"
    `include "rd_in_monitor.svh"
    `include "rd_in_agent.svh"

    // Include files from the rd_out uVC
    `include "rd_out_seq_item.svh"
    `include "rd_out_config.svh"
    //`include "rd_out_driver.svh"
    `include "rd_out_monitor.svh"
    `include "rd_out_agent.svh"

    // Include files from the rs1 uVC
    `include "rs1_seq_item.svh"
    `include "rs1_seq.svh"
    `include "rs1_config.svh"
    `include "rs1_driver.svh"
    `include "rs1_monitor.svh"
    `include "rs1_agent.svh"

    // Include files from the rs2 uVC
    `include "rs2_seq_item.svh"
    `include "rs2_seq.svh"
    `include "rs2_config.svh"
    `include "rs2_driver.svh"
    `include "rs2_monitor.svh"
    `include "rs2_agent.svh"

    // Include files from the ZeroFlag uVC
    `include "ZeroFlag_seq_item.svh"
    `include "ZeroFlag_config.svh"
    //`include "ZeroFlag_driver.svh"
    `include "ZeroFlag_monitor.svh"
    `include "ZeroFlag_agent.svh"

    // Include files from the TB
    `include "scoreboard.svh"
    `include "top_config.svh"
    `include "tb_env.svh"
    `include "base_test.svh"
    `include "basic_test.svh"
endpackage: tb_pkg
