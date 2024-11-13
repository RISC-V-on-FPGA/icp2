//------------------------------------------------------------------------------
// control_in_if interface
//
// This interface provides a control_in output signal.
//
//------------------------------------------------------------------------------
interface control_in_if (input logic clk, input logic rst_n);
    // control_in output signal.        kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????

    // skall denna vara "bit[31:0]" istället -> det är i alla fall vad vi skickar till vår monitor eller är det viktigt med control type när vi skickar saker till DUT ??????
    bit[31:0] control_in;
endinterface : control_in_if

