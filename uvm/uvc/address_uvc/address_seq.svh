//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "address_seq_item.svh"  // Include the item file

class address_seq extends uvm_sequence #(address_seq_item);
    `uvm_object_utils(address_seq)

    rand bit [4:0] address;
    
    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="address_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // Create sequence
        req = address_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.address == local::address;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : address_seq