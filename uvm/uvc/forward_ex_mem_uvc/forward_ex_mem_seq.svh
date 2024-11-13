//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "forward_ex_mem_seq_item.svh"  // Include the item file

class forward_ex_mem_seq extends uvm_sequence #(forward_ex_mem_seq_item);
    `uvm_object_utils(forward_ex_mem_seq)

    rand bit [31:0] forward_ex_mem;

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="forward_ex_mem_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // From chat ;)
        `uvm_info("forward_ex_mem_seq", "Starting forward_ex_mem_seq body", UVM_MEDIUM)

        // Randomize fields
        if (!this.randomize()) begin
            `uvm_error("forward_ex_mem_seq", "Randomization failed")
            return;
        end

        // Pack the control fields
        pack_forward_ex_mem();

        // Optionally display or perform actions with forward_ex_mem here
        `uvm_info("forward_ex_mem_seq", $sformatf("Packed forward_ex_mem: %h", forward_ex_mem), UVM_MEDIUM)
        // Create sequence
        req = forward_ex_mem_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.forward_ex_mem == local::forward_ex_mem;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : forward_ex_mem_seq
