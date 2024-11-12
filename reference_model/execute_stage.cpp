// reference_model.cpp

#include "execute_stage.h"
#include <cstdint>
// #include <ios>
#include <ios>
#include <ostream>

class ExecuteStage {
public:
    ExecuteStage() = default;

    // Initialize the model
    void initialize() {
        std::cout << "Initializing reference model..." << std::endl;

        control_out  = 0;
        ZeroFlag     = 0;
        alu_data     = 0;
        memory_data  = 0;
        rd_out       = 0;
        pc_out       = 0;

        std::cout << "Reference model initialized" << std::endl;
    }

    // Process: Do all the operations and stuff that happens inside the execution stage. Returns 1 of success
    int process(
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
    ) {
        std::cout << "Processing inputs..." << std::endl;
        // Control is 4+3+6+3=16 bits
        int ALUOp = (control_in >> 12) & 0xF; // ALUOp is [15:12]
        int ALUSrc = (control_in >> 8) & 0b1; // ALUSrc is [8]
        
        int32_t left_operand;
        int32_t right_operand;

        // Calculate things necessary to figure out operands
        
        // Forwarding unit
        int mux_ctrl_left;
        int mux_ctrl_right;
        forwarding_unit(rs1, 
                        rs2, 
                        rd_in, 
                        ex_mem_rd, 
                        mem_wb_rd, 
                        mem_wb_RegWrite, 
                        ex_mem_RegWrite, 
                        &mux_ctrl_left, 
                        &mux_ctrl_right);

        // Figure out left_operand
        if      (mux_ctrl_left == Forward_def)     left_operand = data1;
        else if (mux_ctrl_left == Forward_ex_mem)  left_operand = forward_ex_mem;
        else if (mux_ctrl_left == Forward_mem_wb)  left_operand = forward_mem_wb;

        // Figure out right_operand
        // First mux
        if      (mux_ctrl_right == Forward_def)    right_operand = data2;
        else if (mux_ctrl_right == Forward_ex_mem) right_operand = forward_ex_mem;
        else if (mux_ctrl_right == Forward_mem_wb) right_operand = forward_mem_wb;

        memory_data = right_operand; // left_operand before second mux
        
        // Second mux
        if (ALUSrc == 1) right_operand = immediate_data;

        // ALU sets ZeroFlag and alu_data
        alu(ALUOp, left_operand, right_operand, &ZeroFlag, &alu_data);

        // Things that go straight through
        control_out = control_in;
        pc_out = pc;
        rd_out = rd_in;

        std::cout << "Processing finished. Outputs ready" << std::endl;

        return 1;
    }

    // Implement "get functions" to be able to see what the output is after process
    int get_control_out() {
        std::cout << "Returning control_out: " << control_out << std::endl;
        return control_out;
    }

    int get_ZeroFlag() {
        std::cout << "Returning ZeroFlag: " << ZeroFlag << std::endl;
        return ZeroFlag;
    }

    int get_alu_data() {
        std::cout << "Returning alu_data: " << alu_data << std::endl;
        return alu_data;
    }

    int get_memory_data() {
        std::cout << "Returning memory_data: " << memory_data << std::endl;
        return memory_data;
    }

    int get_rd_out() {
        std::cout << "Returning rd_out: " << rd_out << std::endl;
        return rd_out;
    }

    int get_pc_out() {
        std::cout << "Returning pc_out: " << pc_out << std::endl;
        return pc_out;
    }

    // Finalize or clean up the model
    void finalize() {
        std::cout << "Finalizing reference model..." << std::endl;

        control_out  = 0;
        ZeroFlag     = 0;
        alu_data     = 0;
        memory_data  = 0;
        rd_out       = 0;
        pc_out       = 0;

        std::cout << "Reference model finalized" << std::endl;
    }

private:
    int control_out;
    int ZeroFlag;
    int alu_data;
    int memory_data;
    int rd_out;
    int pc_out;

    /** 
    * ************************************************************************
    * ****** FORWARDING UNIT *************************************************
    * ************************************************************************
    */

    void forwarding_unit(
        int rs1,
        int rs2,
        int rd,
        int ex_mem_rd,
        int mem_wb_rd,
        int mem_wb_RegWrite,
        int ex_mem_RegWrite,
        int* mux_ctrl_left,
        int* mux_ctrl_right) {

        // Logic for mux_ctrl_left
        if (mem_wb_RegWrite
            && (mem_wb_rd != 0)
            && !(ex_mem_RegWrite && (ex_mem_rd != 0) && ex_mem_rd == rs1)
            && (mem_wb_rd == rs1)) {
            *mux_ctrl_left = Forward_mem_wb;
        } else if (ex_mem_RegWrite && (ex_mem_rd != 0) && (ex_mem_rd == rs1)) {
            *mux_ctrl_left = Forward_ex_mem;
        } else {
            *mux_ctrl_left = Forward_def;
        }

        // Logic for mux_ctrl_right
        if (mem_wb_RegWrite
            && (mem_wb_rd != 0)
            && !(ex_mem_RegWrite && (ex_mem_rd != 0) && ex_mem_rd == rs2)
            && (mem_wb_rd == rs2)) {
            *mux_ctrl_right = Forward_mem_wb;
        } else if (ex_mem_RegWrite && (ex_mem_rd != 0) && (ex_mem_rd == rs2)) {
            *mux_ctrl_right = Forward_ex_mem;
        } else {
            *mux_ctrl_right = Forward_def;
        }
    }

    /** 
    * ************************************************************************
    * ****** ALU *************************************************************
    * ************************************************************************
    */

    void alu( // TODO: The ALU must act correctly on overflow stuff. Make sure this is true
            int ALUOp,
            int left_operand,
            int right_operand,
            int* ZeroFlag,
            int* alu_data) {
        
        switch (ALUOp) {
            case ALU_SLL:
                *alu_data = left_operand << (right_operand % 32);
                break;
            case ALU_SRL:
                *alu_data = (unsigned)left_operand >> (right_operand % 32);
                break;
            case ALU_SRA:
                if (left_operand < 0 && right_operand > 0) {
                    *alu_data = left_operand >> right_operand | ~(~0U >> right_operand);
                } else {
                    *alu_data = left_operand >> right_operand;
                }
                break;

            case ALU_ADD:
                *alu_data = left_operand + right_operand;
                break;
            case ALU_SUB:
                *alu_data = left_operand - right_operand;
                break;
            case ALU_LUI:
                *alu_data = right_operand;
                break;

            case ALU_AND:
                *alu_data = left_operand & right_operand;
                break;
            case ALU_OR:
                *alu_data = left_operand | right_operand;
                break;
            case ALU_XOR:
                *alu_data = left_operand ^ right_operand;
                break;

            case ALU_SLTU:
                *alu_data = (unsigned)left_operand < (unsigned)right_operand;
                break;

            case ALU_SLT:
                *alu_data = left_operand < right_operand;
                break;

            default:
                *alu_data = left_operand + right_operand;
                break;
        }

        *ZeroFlag = (*alu_data == 0); // Set ZeroFlag if result is zero
        }
};

// Global instance of the ReferenceModel
ExecuteStage model;

// Extern "C" functions for DPI-C access

// Function to initialize the model
extern "C" void initialize_model() {
    model.initialize();
}

// Function to process data, receiving input from SystemVerilog and returning output
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
) {
    return model.process(pc, 
                         control_in, 
                         data1, 
                         data2, 
                         immediate_data, 
                         rd_in, 
                         rs1, 
                         rs2, 
                         ex_mem_rd, 
                         mem_wb_rd, 
                         ex_mem_RegWrite, 
                         mem_wb_RegWrite,
                         forward_ex_mem,
                         forward_mem_wb);
}
extern "C" int get_control_out() {
    return model.get_control_out();
}
extern "C" int get_ZeroFlag() {
    return model.get_ZeroFlag();
}
extern "C" int get_alu_data() {
    return model.get_alu_data();
}
extern "C" int get_memory_data() {
    return model.get_memory_data();
}
extern "C" int get_rd_out() {
    return model.get_rd_out();
}
extern "C" int get_pc_out() {
    return model.get_pc_out();
}

// Function to finalize the model
extern "C" void finalize_model() {
    model.finalize();
}
