//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "RegWrite_seq_item.svh"  // Include the item file

class RegWrite_seq extends uvm_sequence #(RegWrite_seq_item);
    `uvm_object_utils(RegWrite_seq)

    rand bit RegWrite;

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="RegWrite_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // From chat ;)
        `uvm_info("RegWrite_seq", "Starting RegWrite_seq body", UVM_MEDIUM)

        // Randomize fields
        if (!this.randomize()) begin
            `uvm_error("RegWrite_seq", "Randomization failed")
            return;
        end

        // Pack the control fields
        //pack_RegWrite();

        // Optionally display or perform actions with RegWrite here
        `uvm_info("RegWrite_seq", $sformatf("Packed RegWrite: %h", RegWrite), UVM_MEDIUM)
        // Create sequence
        req = RegWrite_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.RegWrite == local::RegWrite;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : RegWrite_seq
