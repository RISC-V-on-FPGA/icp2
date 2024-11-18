//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "data2_seq_item.svh"  // Include the item file

class data2_seq extends uvm_sequence #(data2_seq_item);
    `uvm_object_utils(data2_seq)

    rand bit [31:0] data2;

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="data2_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // From chat ;)
        `uvm_info("data2_seq", "Starting data2_seq body", UVM_MEDIUM)

        // Randomize fields
        if (!this.randomize()) begin
            `uvm_error("data2_seq", "Randomization failed")
            return;
        end

        // Pack the control fields
        //pack_data2();

        // Optionally display or perform actions with data2 here
        `uvm_info("data2_seq", $sformatf("Packed data2: %h", data2), UVM_MEDIUM)
        // Create sequence
        req = data2_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.data2 == local::data2;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : data2_seq
