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

    // Include files from the clock uVC
    `include "clock_config.svh"
    `include "clock_driver.svh"
    `include "clock_agent.svh"

    // Include files from the control_in uVC
    `include "control_seq_item.svh"
    `include "control_seq.svh"
    `include "control_config.svh"
    `include "control_driver.svh"
    `include "control_monitor.svh"
    `include "control_agent.svh"

    // Include files from the RegWrite uVC
    `include "RegWrite_seq_item.svh"
    `include "RegWrite_seq.svh"
    `include "RegWrite_config.svh"
    `include "RegWrite_driver.svh"
    `include "RegWrite_monitor.svh"
    `include "RegWrite_agent.svh"

    // Include files from the data uVC
    `include "data_seq_item.svh"
    `include "data_seq.svh"
    `include "data_config.svh"
    `include "data_driver.svh"
    `include "data_monitor.svh"
    `include "data_agent.svh"

    // Include files from the pc uVC
    `include "pc_seq_item.svh"
    `include "pc_seq.svh"
    `include "pc_config.svh"
    `include "pc_driver.svh"
    `include "pc_monitor.svh"
    `include "pc_agent.svh"

    // Include files from the address uVC
    `include "address_seq_item.svh"
    `include "address_seq.svh"
    `include "address_config.svh"
    `include "address_driver.svh"
    `include "address_monitor.svh"
    `include "address_agent.svh"

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
