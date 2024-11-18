//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "mem_wb_RegWrite_seq_item.svh"  // Include the item file

class mem_wb_RegWrite_seq extends uvm_sequence #(mem_wb_RegWrite_seq_item);
    `uvm_object_utils(mem_wb_RegWrite_seq)

    rand bit mem_wb_RegWrite;

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="mem_wb_RegWrite_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // From chat ;)
        `uvm_info("mem_wb_RegWrite_seq", "Starting mem_wb_RegWrite_seq body", UVM_MEDIUM)

        // Randomize fields
        if (!this.randomize()) begin
            `uvm_error("mem_wb_RegWrite_seq", "Randomization failed")
            return;
        end

        // Pack the control fields
        //pack_mem_wb_RegWrite();

        // Optionally display or perform actions with mem_wb_RegWrite here
        `uvm_info("mem_wb_RegWrite_seq", $sformatf("Packed mem_wb_RegWrite: %h", mem_wb_RegWrite), UVM_MEDIUM)
        // Create sequence
        req = mem_wb_RegWrite_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.mem_wb_RegWrite == local::mem_wb_RegWrite;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : mem_wb_RegWrite_seq
