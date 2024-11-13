//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// // Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class control_out_seq_item extends uvm_sequence_item;

    // Array with serial data bits
    rand bit [31:0] control_out;

    // Specify how variables shall be printed out
    `uvm_object_utils_begin(control_out_seq_item)
    `uvm_field_int(control_out,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "control_out_seq_item");
        super.new(name);
    endfunction : new

endclass : control_out_seq_item
