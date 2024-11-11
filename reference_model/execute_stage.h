// reference_model.h

#ifndef REFERENCE_MODEL_H
#define REFERENCE_MODEL_H

#include <cstdint>
#include <iostream>
#include <vector>

// Function declarations
extern "C" void initialize_model();
extern "C" int process_data(
    int pc,
    int control_in,
    int data1,
    int data2,
    int immediate_data,
    int rd_in,
    // Forward unit inputs
    int rs1,
    int rs2,
    int ex_mem_rd,
    int mem_wb_rd,
    int ex_mem_RegWrite,
    int mem_wb_RegWrite,
    // Forwarded data from upcoming pipeline stages
    int forward_ex_mem,
    int forward_mem_wb
);
extern "C" void finalize_model();

// ALU operation codes using #define for C++
#define ALU_SLL  0b0000  // Shift Left Logical (Fill with 0's)
#define ALU_SRL  0b0001  // Shift Right Logical (Fill with 0's)
#define ALU_SRA  0b0010  // Shift Right Arithmetic (Sign bit preserved)

// Arithmetic operations
#define ALU_ADD  0b0100
#define ALU_SUB  0b0101
#define ALU_LUI  0b0110  // Not sure if ALU is needed for this, but for reservation

// Logical operations
#define ALU_XOR  0b1000
#define ALU_OR   0b1001
#define ALU_AND  0b1010

// Compare operations
#define ALU_SLT  0b1100  // Set <
#define ALU_SLTU 0b1101  // Set < Unsigned

#define Forward_def     0b00
#define Forward_ex_mem  0b10
#define Forward_mem_wb  0b01

#endif  // REFERENCE_MODEL_H
