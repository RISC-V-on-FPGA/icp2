//------------------------------------------------------------------------------
// forward_ex_mem interface
//
// This interface provides a forward_ex_mem output signal.
// 
//------------------------------------------------------------------------------
interface forward_ex_mem_if (input logic clk, input logic rst_n);
    // forward_ex_mem output signal.
    logic[31:0] forward_ex_mem;
endinterface : forward_ex_mem_if
