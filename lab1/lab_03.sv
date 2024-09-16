module lab_03;


    class Test1;
        task run;
            $display("\nTest 1");

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #20 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);

            fork
                #60 $display("Fork - thread 1 @ line %0d @ time %0t", `__LINE__, $time);
                #10 $display("Fork - thread 2 @ line %0d @ time %0t", `__LINE__, $time);
            join

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #100 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
        endtask;
    endclass: Test1

    // Create a new class named "Task1" that is a carbon copy of the "Test1" class with the exception that the "fork-join" block only creates 1 thread.
    class Task1_Test1;
        task run;
            $display("\nTest 1 with only 1 thread");

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #20 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);

            fork
                #60 $display("Fork - thread 1 @ line %0d @ time %0t", `__LINE__, $time);
                // #10 $display("Fork - thread 2 @ line %0d @ time %0t", `__LINE__, $time);
            join

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #100 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
        endtask;
    endclass: Task1_Test1


    class Test2;
        task run;
            $display("\nTest 2");

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #20 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);

            fork
                #60 $display("Fork - thread 1 @ line %0d @ time %0t", `__LINE__, $time);
                #10 $display("Fork - thread 2 @ line %0d @ time %0t", `__LINE__, $time);
            join_any

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #100 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);            
        endtask;
    endclass: Test2


    class Test3;
        task run;
            $display("\nTest 3");

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #20 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);

            fork
                #60 $display("Fork - thread 1 @ line %0d @ time %0t", `__LINE__, $time);
                #10 $display("Fork - thread 2 @ line %0d @ time %0t", `__LINE__, $time);
            join_none

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #100 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);            
        endtask;
    endclass: Test3


    class Test4;
        task run;
            $display("\nTest 4");

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #20 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);

            fork
                #60 $display("Fork - thread 1 @ line %0d @ time %0t", `__LINE__, $time);
                #10 $display("Fork - thread 2 @ line %0d @ time %0t", `__LINE__, $time);
            join_any
            disable fork;

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #100 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);            
        endtask;
    endclass: Test4


    class Test5;
        task run;
            $display("\nTest 5");

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #20 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);

            fork
                #60 $display("Fork - thread 1 @ line %0d @ time %0t", `__LINE__, $time);
                #10 $display("Fork - thread 2 @ line %0d @ time %0t", `__LINE__, $time);
            join_any
        
            fork
                begin
                    #10 $display("Fork2 - thread 3 @ line %0d @ time %0t", `__LINE__, $time);
                    #20 $display("Fork2 - thread 3 @ line %0d @ time %0t", `__LINE__, $time);
                    #80 $display("Fork2 - thread 3 @ line %0d @ time %0t", `__LINE__, $time);
                end
            join_none

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);

            wait fork;

            #100 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);            
        endtask;
    endclass: Test5

    // Create a new class named "Task2" that is a carbon copy of the "Test5" class with the exception that the threads created in the "fork-join" blocks need to finish first before moving on      
    class Task2_Test5;
        task run;
            $display("\nTest 5 - Task2");

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);
            #20 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);

            fork
                #60 $display("Fork - thread 1 @ line %0d @ time %0t", `__LINE__, $time);
                #10 $display("Fork - thread 2 @ line %0d @ time %0t", `__LINE__, $time);
            join_any

            wait fork;
        
            fork
                begin
                    #10 $display("Fork2 - thread 3 @ line %0d @ time %0t", `__LINE__, $time);
                    #20 $display("Fork2 - thread 3 @ line %0d @ time %0t", `__LINE__, $time);
                    #80 $display("Fork2 - thread 3 @ line %0d @ time %0t", `__LINE__, $time);
                end
            join_none

            wait fork;

            #10 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);

            #100 $display("Main - thread @ line %0d @ time %0t", `__LINE__, $time);            
        endtask;
    endclass: Task2_Test5

    initial begin
        Test1 test1;
        Test2 test2;
        Test3 test3;
        Test4 test4;
        Test5 test5;
        Task1_Test1 t1;
        Task2_Test5 t2;

        // test1 = new();
        // test1.run();

        // test2 = new();
        // test2.run();

        // test3 = new();
        // test3.run();

        // test4 = new();
        // test4.run();

        // test5 = new();
        // test5.run();

        // t1 = new();
        // t2 = new();

        // Task 1
        // Create a new class named "Task1" that is a carbon copy of the "Test1" class with the exception that the "fork-join" block only creates 1 thread.
        // t1.run();

        // Task 2
        // Create a new class named "Task2" that is a carbon copy of the "Test5" class with the exception that the threads created in the "fork-join" blocks need to finish first before moving on      
        t2.run();

    end

endmodule
