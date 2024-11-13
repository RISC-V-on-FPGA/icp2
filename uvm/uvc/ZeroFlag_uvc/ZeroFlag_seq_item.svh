//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// // Include basic packages
// import uvm_pkg::*;
// `include "uvm_macros.svh"

class ZeroFlag_seq_item extends uvm_sequence_item;

    // Array with serial data bits
    rand bit ZeroFlag;

    // Specify how variables shall be printed out
    `uvm_object_utils_begin(ZeroFlag_seq_item)
    `uvm_field_int(ZeroFlag,UVM_ALL_ON|UVM_DEC)
    `uvm_object_utils_end

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name = "ZeroFlag_seq_item");
        super.new(name);
    endfunction : new

endclass : ZeroFlag_seq_item
