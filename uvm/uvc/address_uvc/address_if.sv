//------------------------------------------------------------------------------
// address_if interface
//
// This interface provides a address output signal.
//
//------------------------------------------------------------------------------
interface address_if (input logic clk, input logic rst_n);
    // address output signal.        kanske behöver importera komponenter från kommon för att han skall fatta vad control_type är?????????????????????

    // skall denna vara "bit[31:0]" istället -> det är i alla fall vad vi skickar till vår monitor eller är det viktigt med control type när vi skickar saker till DUT ??????
    bit[4:0] address;
endinterface : address_if

