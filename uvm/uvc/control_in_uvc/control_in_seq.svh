//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class control_in_seq extends uvm_sequence #(control_in_seq_item);
    `uvm_object_utils(control_in_seq)

    rand bit[31:0] control_in;

    //TODO: Add the different fields in control_in (controltype), to be randomized and assigned to control_in.
    rand bit [3:0] ALUop;
    rand bit [2:0] encoding;
    rand bit       ALUsrc;
    rand bit       MemRead;
    rand bit       MemWrite;
    rand bit       RegWrite;
    rand bit       MemtoReg;
    rand bit       is_branch;
    rand bit [2:0] BranchType;

    control_in = {ALUop,
                 encoding,
                 ALUsrc,
                 MemRead,
                 MemWrite,
                 RegWrite,
                 MemtoReg,
                 is_branch,
                 BranchType}; // This might not work, but looks nice ??????

    constraint ALUop {
        ALUop == {4'b0000 ||
                  4'b0001 ||
                  4'b0010 ||
                  4'b0100 ||
                  4'b0101 ||
                  4'b0110 ||
                  4'b1000 ||
                  4'b1001 ||
                  4'b1010 ||
                  4'b1100 ||
                  4'b1101;} //Might not work, :( ??????
    }

    constraint encoding {
        encoding <= 6; 
    }

    constraint BranchType {
        BranchType <= 6;
    }

    //------------------------------------------------------------------------------
    // The constructor for the sequence.
    //------------------------------------------------------------------------------
    function new(string name="control_in_seq");
        super.new(name);
    endfunction : new

    //------------------------------------------------------------------------------
    // The main task to be executed within the sequence.
    //------------------------------------------------------------------------------
    task body();
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