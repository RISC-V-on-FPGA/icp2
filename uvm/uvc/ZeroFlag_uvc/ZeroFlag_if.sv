//------------------------------------------------------------------------------
// ZeroFlag_if interface
//
// This interface provides a ZeroFlag output signal.
// 
//------------------------------------------------------------------------------
interface ZeroFlag_if (input logic clk, input logic rst_n);
    // ZeroFlag output signal.        kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    
    
    bit ZeroFlag;    
endinterface : ZeroFlag_if

