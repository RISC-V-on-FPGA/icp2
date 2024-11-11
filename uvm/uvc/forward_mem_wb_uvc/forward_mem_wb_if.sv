//------------------------------------------------------------------------------
// forward_mem_wb interface
//
// This interface provides a forward_mem_wb output signal.
// 
//------------------------------------------------------------------------------
interface forward_mem_wb_if ();
    // forward_mem_wb output signal.
    logic[31:0] forward_mem_wb;
endinterface : forward_mem_wb_if

