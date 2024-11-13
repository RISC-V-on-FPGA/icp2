//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "forward_mem_wb_seq_item.svh"  // Include the item file

class forward_mem_wb_seq extends uvm_sequence #(forward_mem_wb_seq_item);
    `uvm_object_utils(forward_mem_wb_seq)

    rand bit [31:0] forward_mem_wb;

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="forward_mem_wb_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // From chat ;)
        `uvm_info("forward_mem_wb_seq", "Starting forward_mem_wb_seq body", UVM_MEDIUM)

        // Randomize fields
        if (!this.randomize()) begin
            `uvm_error("forward_mem_wb_seq", "Randomization failed")
            return;
        end

        // Pack the control fields
        pack_forward_mem_wb();

        // Optionally display or perform actions with forward_mem_wb here
        `uvm_info("forward_mem_wb_seq", $sformatf("Packed forward_mem_wb: %h", forward_mem_wb), UVM_MEDIUM)
        // Create sequence
        req = forward_mem_wb_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.forward_mem_wb == local::forward_mem_wb;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : forward_mem_wb_seq
