//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
interface RegWrite_if (input logic clk, input logic rst_n);
    // RegWrite output signal.
    logic[31:0] RegWrite;
endinterface : RegWrite_if

