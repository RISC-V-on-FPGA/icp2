//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "data_seq_item.svh"  // Include the item file

class data_seq extends uvm_sequence #(data_seq_item);
    `uvm_object_utils(data_seq)

    rand bit [31:0] data;

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="data_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // From chat ;)
        `uvm_info("data_seq", "Starting data_seq body", UVM_MEDIUM)

        // Randomize fields
        if (!this.randomize()) begin
            `uvm_error("data_seq", "Randomization failed")
            return;
        end

        // Pack the control fields
        //pack_data();

        // Optionally display or perform actions with data here
        `uvm_info("data_seq", $sformatf("Packed data: %h", data), UVM_MEDIUM)
        // Create sequence
        req = data_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.data == local::data;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : data_seq
