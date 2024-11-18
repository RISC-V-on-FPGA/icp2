//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "data1_seq_item.svh"  // Include the item file

class data1_seq extends uvm_sequence #(data1_seq_item);
    `uvm_object_utils(data1_seq)

    rand bit [31:0] data1;

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="data1_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // From chat ;)
        `uvm_info("data1_seq", "Starting data1_seq body", UVM_MEDIUM)

        // Randomize fields
        if (!this.randomize()) begin
            `uvm_error("data1_seq", "Randomization failed")
            return;
        end

        // Pack the control fields
        //pack_data1();

        // Optionally display or perform actions with data1 here
        `uvm_info("data1_seq", $sformatf("Packed data1: %h", data1), UVM_MEDIUM)
        // Create sequence
        req = data1_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.data1 == local::data1;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : data1_seq
