import tb_pkg::*;
//------------------------------------------------------------------------------------------------
// Section 0
// We will use the Randomizer to generate random constrained stimuli.
//------------------------------------------------------------------------------------------------
class RANDOMIZER;
    // Task 2: Modify this class so that we can randomize 
    rand opcode op;
    rand logic[7:0] operand_1;
    rand logic[7:0] operand_2;
    constraint yappa {
        operand_1 < 256;
        operand_1 >= 0;
        operand_2 >= 0;
        operand_2 <256;
    }
    constraint opcode_constraint {op < 5;}
    //constraint op_constraint {
    //    operand_1 dist {0       := 1,
    //                    [1:254] := 1,
    //                    255     := 2};
//
    //    operand_2 dist {0       := 1,
    //                    [1:254] := 1,
    //                    255     := 2};
    //}

endclass

module simple_alu_tb;

    //------------------------------------------------------------------------------
    // Section 1
    // TB internal signals
    //------------------------------------------------------------------------------    
    logic           tb_clock;
    logic           tb_reset_n;
    logic           tb_start_bit;
    logic [7:0]    tb_operand_1;
    logic [7:0]    tb_operand_2;
    logic [7:0]    tb_result;
    logic [7:0]     tb_max_count;
    opcode          tb_opcode;
    

    //------------------------------------------------------------------------------
    // Section 2
    // Initialize signals
    //------------------------------------------------------------------------------    
    initial begin
        tb_clock = 0;
        tb_reset_n = 0;
        tb_start_bit = 0;
        tb_operand_1 = 0;
        tb_operand_2 = 0;
        tb_max_count = 0;
    end

    //------------------------------------------------------------------------------
    // Section 3
    // Instantiation of mysterybox DUT (Design Under Test)(The thing we want to look at :)
    //------------------------------------------------------------------------------
    simple_alu DUT (
        .clock(tb_clock),
        .reset_n(tb_reset_n),
        .start(tb_start_bit),
        .a(tb_operand_1),
        .b(tb_operand_2),
        .c(tb_result),
        .mode_select(tb_opcode)
    );
    RANDOMIZER randy = new();
    //------------------------------------------------------------------------------
    // Section 4
    // Clock generator.
    //------------------------------------------------------------------------------
    initial begin
        forever begin
            tb_clock = #5ns ~tb_clock;
        end
    end

    //------------------------------------------------------------------------------
    // Section 5
    // Task to generate Reset simulus
    //------------------------------------------------------------------------------
    task automatic reset(int delay, int length);
        $display("%0t reset():            Starting delay=%0d length=%0d",$time(), delay, length);
        //Repeat doing nothing for the clock delay
        repeat(delay) @(posedge tb_clock);

        tb_reset_n <= 0;
        $display("%0t reset():            Reset activated",$time());
        // Min 1 clock that reset bit is active. Use a do while loop for that!
        do begin
            @(posedge tb_clock);
        end while (--length > 0);
        tb_reset_n <= 1;
        $display("%0t reset():            Reset released",$time());
    endtask


    //------------------------------------------------------------------------------
    // Section 6
    // Task to generate start bit simulus
    //------------------------------------------------------------------------------
    task automatic start_bit(int delay, int length);
        $display("%0t start_bit():        Starting delay=%0d length=%0d",$time(), delay, length);
        // Min 1 clock synchronize start bit 
        do begin
            @(posedge tb_clock);
        end while (--delay > 0);
        tb_start_bit <= 1;
        $display("%0t start_bit():        Start bit activated ",$time());
        // Min 1 clock that start bit is active
        do begin
            @(posedge tb_clock);
        end while (--length > 0);
        tb_start_bit <= 0;
        $display("%0t start_bit():        Start bit released ",$time());
    endtask

    //------------------------------------------------------------------------------
    // Section 7
    // Task to simplify generation of signals.
    //------------------------------------------------------------------------------
    task automatic do_math(int a,int b,opcode code);
        // if(randy.randomize())
        //     $display("Randomization done! :D");
        // else 
        //    $error("Failed to randomize :(");
        // $display("%0t do_math:   Opcode:%0s     First number=%0d Second Value=%0d",$time(),code.name(), a, b);

        @(posedge tb_clock);
        tb_start_bit <= 1;
        tb_operand_1 <= a;
        tb_operand_2 <= b;
        tb_opcode<= code;
        @(posedge tb_clock);
        tb_operand_1 <= '0;
        tb_operand_2 <= '0;
        tb_start_bit <= 0;
    endtask

    //------------------------------------------------------------------------------
    // Section 8
    // Functional coverage definitions. Expand on this!!!
    //------------------------------------------------------------------------------
    
    covergroup basic_fcov @(negedge tb_clock);
        reset:coverpoint tb_reset_n{
            bins reset = { 0 };
            bins run =   { 1 };
        }

    endgroup: basic_fcov

    covergroup do_math_fcov @(posedge tb_clock && tb_start_bit == 1);
        // if (tb_start_bit) begin
            //Task 3: Expand our coverage...
            tb_opcode:coverpoint tb_opcode{
                bins opcode = { [0:4] };
            }
            tb_a:coverpoint tb_operand_1{
                bins min[] = { 0 };
                bins med[4] = { [1:254] };
                bins max[] = { 255 };
            }
            tb_b:coverpoint tb_operand_2{
                bins min[] = { 0 };
                bins med[4] = { [1:254] };
                bins max[] = { 255 };
            }
            tb_c:coverpoint tb_result{
                bins min[] = { 0 };
                bins med[4] = { [1:254] };
                bins max[] = { 255 };
            }

            //Task 5: Add some crosses aswell to get some granularity going!
            cp_operand_1_opcode_criss_cross: cross tb_a, tb_opcode;
            cp_operand_2_opcode_criss_cross: cross tb_b, tb_opcode; 
            cp_opcode_tb_c_criss_cross: cross tb_c, tb_opcode {
                ignore_bins div_zero = cp_opcode_tb_c_criss_cross with (tb_opcode == DIV && tb_operand_2 == 0);
                ignore_bins mod_255 = cp_opcode_tb_c_criss_cross with (tb_opcode == MOD && tb_result == 255);
            } // ta bort mod 255, går ej, vet ej hur man gör :(

        // end
    endgroup: do_math_fcov

    basic_fcov coverage_instance;
    do_math_fcov coverage_instance_1;

    //------------------------------------------------------------------------------
    // Section 9
    // Task 4: Now change your test case , and the number of times you run it so that your input stim
    //Here we will start our meat and potatoes of the test.
    //------------------------------------------------------------------------------
    task test_case();
        reset(.delay(0), .length(2));

        repeat(100000) begin
            randy.randomize();
            do_math(randy.operand_1, randy.operand_2, randy.op);
            #10ns;
        end

        reset(.delay(10), .length(2));
        // Task 1: The DUT is causing this assertion to be hit...
        assert (tb_result == 0) 
            $display ("Output reset");
        else
            $error("Reset doesn't clear output!");
        

    endtask

    //------------------------------------------------------------------------------
    // Section 10
    // Start test case from time 0
    //------------------------------------------------------------------------------
    initial begin
        // Here we can call our tests. Start by initializing our coverage!
        coverage_instance = new();
        coverage_instance_1 = new();
        
        //Uncomment this to try randomizing internal randomizable variables.
        // if(randy.randomize(operand_1))
        //     $display("Randomization done! :D");
        // else 
        //    $error("Failed to randomize :(");
        $display("*****************************************************");
        $display("Starting Tests");
        $display("*****************************************************");
        test_case();

        $display("*****************************************************");
        $display("Tests Finished!");
        $display("*****************************************************");

        $stop;
    end

endmodule
