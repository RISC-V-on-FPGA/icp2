//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// // Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class pc_seq_item extends uvm_sequence_item;

    // Array with serial data bits
    rand bit [31:0] pc;
    // Monitor start bit value
    bit monitor_start_bit_value;
    // Monitor start bit value valid
    bit monitor_start_bit_valid;
    // Monitor finshed of serial data
    bit monitor_data_valid;

    // Specify how variables shall be printed out
    `uvm_object_utils_begin(pc_seq_item)
    `uvm_field_int(pc,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(monitor_start_bit_value,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(monitor_start_bit_valid,UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(monitor_data_valid,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "pc_seq_item");
        super.new(name);
    endfunction : new

endclass : pc_seq_item
