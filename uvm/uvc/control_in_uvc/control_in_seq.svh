//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "control_in_seq_item.svh"  // Include the item file

class control_in_seq extends uvm_sequence #(control_in_seq_item);
    `uvm_object_utils(control_in_seq)

    rand bit [31:0] control_in;

    // Fields to be randomized
    rand bit [3:0] ALUop;
    rand bit [2:0] encoding;
    rand bit       ALUsrc;
    rand bit       MemRead;
    rand bit       MemWrite;
    rand bit       RegWrite;
    rand bit       MemtoReg;
    rand bit       is_branch;
    rand bit [2:0] BranchType;

    // Valid ALU operation codes
    constraint alu_op_c {
        ALUop inside {4'b0000, 4'b0001, 4'b0010, 4'b0100, 4'b0101, 4'b0110,
                      4'b1000, 4'b1001, 4'b1010, 4'b1100, 4'b1101};
    }

    constraint encoding_c {
        encoding <= 6;
    }

    constraint branch_type_c {
        BranchType <= 6;
    }

    // Function to pack the fields into control_in
    function void pack_control_in();
        control_in = {ALUop, encoding, ALUsrc, MemRead, MemWrite, RegWrite, MemtoReg, is_branch, BranchType};
    endfunction

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name ="control_in_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
        // From chat ;)
        `uvm_info("control_in_seq", "Starting control_in_seq body", UVM_MEDIUM)

        // Randomize fields
        if (!this.randomize()) begin
            `uvm_error("control_in_seq", "Randomization failed")
            return;
        end

        // Pack the control fields
        pack_control_in();

        // Optionally display or perform actions with control_in here
        `uvm_info("control_in_seq", $sformatf("Packed control_in: %h", control_in), UVM_MEDIUM)
        // Create sequence
        req = control_in_seq_item::type_id::create("req");
        // Wait for sequencer ready
        start_item(req);
        // Randomize sequence item
        if (!(req.randomize() with {
            req.control_in == local::control_in;
        })) `uvm_fatal(get_name(), "Failed to randomize")
        // Send to sequencer
        finish_item(req);
        // Wait until request is completed
        get_response(rsp, req.get_transaction_id());
    endtask : body

endclass : control_in_seq