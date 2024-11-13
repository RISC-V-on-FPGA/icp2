//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// // Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class rd_out_seq_item extends uvm_sequence_item;

    // Array with serial data bits
    rand bit[4:0] rd_out;

    // Specify how variables shall be printed out
    `uvm_object_utils_begin(rd_out_seq_item)
    `uvm_field_int(rd_out,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "rd_out_seq_item");
        super.new(name);
    endfunction : new

endclass : rd_out_seq_item
