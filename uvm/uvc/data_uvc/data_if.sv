//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
interface data_if (input logic clk, input logic rst_n);
    // data output signal.
    logic[31:0] data;
endinterface : data_if

