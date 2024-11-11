#include <iostream>
#include "execute_stage.h"

int main() {
    // Initialize the model
    std::cout << "Initializing the reference model..." << std::endl;
    initialize_model();

    // Test the execute_s    
    std::cout << "Testing the execute stage..." << std::endl;
    
    // Define some test inputs to simulate the execution stage
    int pc = 100;                     // Example Program Counter value
    int control_in = 0x4000;          // Example control signal (16 bits) for add
    int data1 = 10;                   // Example data1 input
    int data2 = 20;                   // Example data2 input
    int immediate_data = 5;           // Example immediate data
    int rd_in = 1;                    // Example destination register input
    int rs1 = 2;                      // Example source register 1
    int rs2 = 3;                      // Example source register 2
    int ex_mem_rd = 0;                // Example value from EX-MEM stage
    int mem_wb_rd = 1;                // Example value from MEM-WB stage
    int ex_mem_RegWrite = 0;          // Example EX-MEM Register Write control signal
    int mem_wb_RegWrite = 0;          // Example MEM-WB Register Write control signal
    int forward_ex_mem = 15;          // Example forwarded data from EX-MEM
    int forward_mem_wb = 30;          // Example forwarded data from MEM-WB

    // Call the process_data function to execute the stage logic
    process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                 rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                 forward_ex_mem, forward_mem_wb);

    get_alu_data();

    // Finalize the model
    std::cout << "Finalizing the reference model..." << std::endl;
    finalize_model();

    return 0;
}
