//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// // Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class pc_out_seq_item extends uvm_sequence_item;

    // Array with serial data bits
    rand bit [31:0] pc_out;

    // Specify how variables shall be printed out
    `uvm_object_utils_begin(pc_out_seq_item)
    `uvm_field_int(pc_out,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "pc_out_seq_item");
        super.new(name);
    endfunction : new

endclass : pc_out_seq_item
