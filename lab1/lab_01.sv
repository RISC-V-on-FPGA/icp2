module lab_01;

    logic [7:0] data;

    typedef enum logic[2:0] {INIT, START, S1, S2, S3, S4, S5, S6} state_t;
    state_t my_state;

    int result;


    initial begin

        randomize_data();

        randomize_my_state();

        randomize_data_with_constraints();

        randomize_my_state_with_constraints();

        randomize_my_state_with_dist_constraints();

        my_state = S2;
        randomize_data_with_conditional_constraints();

        my_state = INIT;
        randomize_data_with_conditional_constraints();

        // Task 1
        // Create a function that randomizes my_state 16 times in a way that it excludes START from the randomization
        task_1_randomize_my_state_with_constraints();
        
        // Task 2
        // Create a function that randomizes data 16 times in a way that it is twice as likely to get data <= 10 than it is to get data >= 200 (and 0 likelihood for 10 < data < 200)
        task_2_randomize_data_with_constraints();

        // Task 3
        // Create a function that randomizes data 16 times in a way that if my_state is [S1:S6] then 50 <= data <= 60 or 100 <= data <= 150, otherwise data <= 20
        task_3_randomize_data_with_conditional_constraints();
        my_state = S2;
        task_3_randomize_data_with_conditional_constraints();


    end

    function void task_1_randomize_my_state_with_constraints;
        $display("TASK 1: Randomize 'my_state' with constraints");
        repeat(16) begin
            result = randomize(my_state) with { 
                my_state inside {
                    INIT, 
                    [S1:S6]
                };
            };
            $display(my_state.name);
        end
        $display("");
    endfunction  

    function void task_2_randomize_data_with_constraints;
        $display("TASK 2: Randomize 'data' with constraints");
        repeat(16) begin
            result = randomize(data) with { 
                data dist {
                   [0:10] :/ 2,
                   [200:255] :/ 1
                };
            };
            $display(data);
        end
        $display("");
    endfunction

    function void task_3_randomize_data_with_conditional_constraints;
        $display("TASK 3: Randomize 'data' with conditional constraints");
        repeat(16) begin
            result = randomize(data) with { 
                my_state == S1 ->  (50 <= data & data <= 60) | (100 <= data & data <= 150); 
                my_state == S2 ->  (50 <= data & data <= 60) | (100 <= data & data <= 150); 
                my_state == S3 ->  (50 <= data & data <= 60) | (100 <= data & data <= 150); 
                my_state == S4 ->  (50 <= data & data <= 60) | (100 <= data & data <= 150); 
                my_state == S5 ->  (50 <= data & data <= 60) | (100 <= data & data <= 150); 
                my_state == S6 ->  (50 <= data & data <= 60) | (100 <= data & data <= 150); 
                my_state == INIT -> data <= 20;
                my_state == START -> data <= 20;
            };
            $display(my_state);
            $display(data);
        end
        $display("");
    endfunction

    function void randomize_data;
        $display("Randomize 'data'");
        repeat(16) begin
            result = randomize(data);
            $display(data);
        end
        $display("");
    endfunction


    function void randomize_my_state;
        $display("Randomize 'my_state'");
        repeat(16) begin
            result = randomize(my_state);
            $display(my_state.name);
        end
        $display("");
    endfunction


    function void randomize_data_with_constraints;
        $display("Randomize 'data' with constraints");
        repeat(16) begin
            result = randomize(data) with { 
                data >= 20; 
                data <= 115; 
            };
            $display(data);
        end
        $display("");
    endfunction


    function void randomize_my_state_with_constraints;
        $display("Randomize 'my_state' with constraints");
        repeat(16) begin
            result = randomize(my_state) with { 
                my_state inside {
                    [INIT:S1], 
                    S3, 
                    S6
                }; 
            };
            $display(my_state.name);
        end
        $display("");
    endfunction


    function void randomize_my_state_with_dist_constraints;
        $display("Randomize 'my_state' with dist constraints");
        repeat(16) begin
            result = randomize(my_state) with { 
                my_state dist {
                    [INIT:S1] := 3, 
                    [S4:S6] := 1
                }; 
            };
            $display(my_state.name);
        end
        $display("");
    endfunction


    function void randomize_data_with_conditional_constraints;
        $display("Randomize 'data' with conditional constraints");
        repeat(16) begin
            result = randomize(data) with { 
                my_state == INIT -> data < 50; 
                my_state == S2 -> data > 100; 
            };
            $display(data);
        end
        $display("");
    endfunction

endmodule
