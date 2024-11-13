//------------------------------------------------------------------------------
// rd_out_if interface
//
// This interface provides a rd_out output signal.
// 
//------------------------------------------------------------------------------
interface rd_out_if (input logic clk, input logic rst_n);
    // rd_out output signal.        kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    
    
    bit[4:0] rd_out;    
endinterface : rd_out_if

