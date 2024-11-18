//------------------------------------------------------------------------------
// clock_if interface
//
// This interface provides a clock output signal.
// 
//------------------------------------------------------------------------------
interface clock_if (input logic clk, input logic rst_n);
    // clock output signal.
    logic clock;
endinterface : clock_if

