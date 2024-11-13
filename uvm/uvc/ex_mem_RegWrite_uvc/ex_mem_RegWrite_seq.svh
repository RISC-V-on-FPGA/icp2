//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "ex_mem_RegWrite_seq_item.svh"  // Include the item file

class ex_mem_RegWrite_seq extends uvm_sequence #(ex_mem_RegWrite_seq_item);
    `uvm_object_utils(ex_mem_RegWrite_seq)

    rand bit ex_mem_RegWrite;

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="ex_mem_RegWrite_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // From chat ;)
        `uvm_info("ex_mem_RegWrite_seq", "Starting ex_mem_RegWrite_seq body", UVM_MEDIUM)

        // Randomize fields
        if (!this.randomize()) begin
            `uvm_error("ex_mem_RegWrite_seq", "Randomization failed")
            return;
        end

        // Pack the control fields
        pack_ex_mem_RegWrite();

        // Optionally display or perform actions with ex_mem_RegWrite here
        `uvm_info("ex_mem_RegWrite_seq", $sformatf("Packed ex_mem_RegWrite: %h", ex_mem_RegWrite), UVM_MEDIUM)
        // Create sequence
        req = ex_mem_RegWrite_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.ex_mem_RegWrite == local::ex_mem_RegWrite;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : ex_mem_RegWrite_seq
