//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// // Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class memory_data_seq_item extends uvm_sequence_item;

    // Array with serial data bits
    rand bit [31:0] memory_data;

    // Specify how variables shall be printed out
    `uvm_object_utils_begin(memory_data_seq_item)
    `uvm_field_int(memory_data,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "memory_data_seq_item");
        super.new(name);
    endfunction : new

endclass : memory_data_seq_item
