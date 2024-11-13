//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "ex_mem_rd_seq_item.svh"  // Include the item file

class ex_mem_rd_seq extends uvm_sequence #(ex_mem_rd_seq_item);
    `uvm_object_utils(ex_mem_rd_seq)

    rand bit [4:0] ex_mem_rd;
    
    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="ex_mem_rd_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // Create sequence
        req = ex_mem_rd_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.ex_mem_rd == local::ex_mem_rd;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : ex_mem_rd_seq