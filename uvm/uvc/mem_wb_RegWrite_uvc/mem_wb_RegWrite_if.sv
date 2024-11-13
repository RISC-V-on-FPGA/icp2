//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
interface mem_wb_RegWrite_if (input logic clk, input logic rst_n);
    // mem_wb_RegWrite output signal.
    logic[31:0] mem_wb_RegWrite;
endinterface : mem_wb_RegWrite_if

