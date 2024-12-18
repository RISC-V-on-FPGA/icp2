#include <cstdint>
#include <iostream>
#include <ostream>
#include "execute_stage.h"
#include <random>
#include <cassert>

#define MAX_INT (2147483647)

int main() {
    // Setup randomization
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> distrib(0,MAX_INT);

    // Initialize the model
    std::cout << "Initializing the reference model..." << std::endl;
    initialize_model();

    // Test the execute_s    
    std::cout << "Testing the execute stage..." << std::endl;
    
    // Inputs 
    int32_t pc, immediate_data, rd_in, rs1, rs2, ex_mem_rd, mem_wb_rd, 
        ex_mem_RegWrite, mem_wb_RegWrite, forward_ex_mem, forward_mem_wb,
        control_in, data1, data2, result;

    /** 
    * ************************************************************************
    * ****** OPERATIONS ******************************************************
    * ************************************************************************
    */

    // test only ALU operations, fix everything else.
    pc = 0;
    immediate_data = 0;
    rd_in = 0;
    rs1 = 0;
    rs2 = 0;
    ex_mem_rd = 0;
    mem_wb_rd = 0;
    ex_mem_RegWrite = 0;
    mem_wb_RegWrite = 0;
    forward_ex_mem = 0;
    forward_mem_wb = 0;

    control_in = (ALU_ADD << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == data1 + data2 && "Add is not correct");
    }
    control_in = (ALU_SUB << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == data1 - data2 && "Sub is not correct");
    }
    control_in = (ALU_SLL << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == (unsigned)data1 << (unsigned)data2 && "Shift left logical is not correct");
    }
    control_in = (ALU_SRL << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == (unsigned)data1 >> (unsigned)data2 && "Shift right logical is not correct");
    }
    control_in = (ALU_SRA << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == data1 >> data2 && "Shift right arithmetic is not correct");
    }
    control_in = (ALU_LUI << 12) + (1 << 8);
    for (int i = 0; i < 100; i++) {
        immediate_data = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == immediate_data && "Load upper immediate is not correct");
    }
    control_in = (ALU_AND << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == (data1 & data2) && "AND is not correct");
    }
    control_in = (ALU_OR << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == (data1 | data2) && "OR is not correct");
    }
    control_in = (ALU_XOR << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == (data1 ^ data2) && "XOR is not correct");
    }
    control_in = (ALU_SLT << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == (data1 < data2) && "SLT is not correct");
    }
    control_in = (ALU_SLTU << 12);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == ((unsigned)data1 < (unsigned)data2) && "SLTU is not correct");
    }

    /** 
    * ************************************************************************
    * ****** IMMEDIATE DATA **************************************************
    * ************************************************************************
    */

    control_in = (ALU_ADD << 12) + (1 << 8);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        immediate_data = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == data1 + immediate_data && "Add immediate is not correct");
    }
    control_in = (ALU_SUB << 12) + (1 << 8);
    for (int i = 0; i < 100; i++) {
        data1 = distrib(gen);
        immediate_data = distrib(gen);

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");
        assert(result == data1 - immediate_data && "Sub immediate is not correct");
    }

    /** 
    * ************************************************************************
    * ****** FORWARDING ******************************************************
    * ************************************************************************
    */

    // TODO: I could expand on this to test every part of the ALU (skip above code) maybe do this later

    control_in = (ALU_ADD << 12);
    for (int i = 0; i < 1000000; i++) {
        data1 = distrib(gen);
        data2 = distrib(gen);
        forward_ex_mem = distrib(gen);
        forward_mem_wb = distrib(gen);

        rs1 = distrib(gen) % 32; // We only have 32 registers
        rs2 = distrib(gen) % 32; // We only have 32 registers
        ex_mem_rd = distrib(gen) % 32; // We only have 32 registers
        mem_wb_rd = distrib(gen) % 32; // We only have 32 registers
        
        ex_mem_RegWrite = distrib(gen) % 2; // Either 1 or 0
        mem_wb_RegWrite = distrib(gen) % 2; // Either 1 or 0

        // Call the process_data function to execute the stage logic
        process_data(pc, control_in, data1, data2, immediate_data, rd_in,
                     rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_RegWrite, mem_wb_RegWrite,
                     forward_ex_mem, forward_mem_wb);

        result = get_alu_data();
        assert(sizeof(result) <= 4 && "Result is larger than 32 bits");

        int left_operand, right_operand;
        // Logic for mux_ctrl_left
        if (mem_wb_RegWrite
            && (mem_wb_rd != 0)
            && !(ex_mem_RegWrite && (ex_mem_rd != 0) && ex_mem_rd == rs1)
            && (mem_wb_rd == rs1)) {
            std::cout << "mem_wb fowarding!!" << std::endl;
            left_operand = forward_mem_wb; 
        } else if (ex_mem_RegWrite && (ex_mem_rd != 0) && (ex_mem_rd == rs1)) {
            std::cout << "ex_mem fowarding!!" << std::endl;
            left_operand = forward_ex_mem;
        } else {
            std::cout << "normal op" << std::endl;
            left_operand = data1;
        }

        // Logic for mux_ctrl_right
        if (mem_wb_RegWrite
            && (mem_wb_rd != 0)
            && !(ex_mem_RegWrite && (ex_mem_rd != 0) && ex_mem_rd == rs2)
            && (mem_wb_rd == rs2)) {
            std::cout << "mem_wb fowarding!!" << std::endl;
            right_operand = forward_mem_wb;
        } else if (ex_mem_RegWrite && (ex_mem_rd != 0) && (ex_mem_rd == rs2)) {
            std::cout << "ex_mem fowarding!!" << std::endl;
            right_operand = forward_ex_mem;
        } else {
            std::cout << "normal op" << std::endl;
            right_operand = data2;
        }

        assert(result = left_operand + right_operand && "Forwarding is not correct") ;

    }


    // Finalize the model
    std::cout << "Finalizing the reference model..." << std::endl;
    finalize_model();

    return 0;
}
