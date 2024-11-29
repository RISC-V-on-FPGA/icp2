//------------------------------------------------------------------------------
// control_if interface
//
// This interface provides a control output signal.
// 
//------------------------------------------------------------------------------
interface control_if (input logic clk, input logic rst_n);
    // control output signal.        kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????
    
    // skall denna vara "bit[31:0]" istället -> det är i alla fall vad vi skickar till vår monitor eller är det viktigt med control type när vi skickar saker till DUT ??????
    bit[31:0] control;    
endinterface : control_if
