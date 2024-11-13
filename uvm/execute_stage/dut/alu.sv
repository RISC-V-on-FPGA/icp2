import common::*;

module alu (
    input wire [3:0] control,
    input wire [31:0] left_operand,
    input wire [31:0] right_operand,
    output logic ZeroFlag,
    output logic [31:0] result
);

  always_comb begin
    case (control)
      // Shifts (To be added)
      ALU_SLL: result = left_operand << (right_operand % 32);
      ALU_SRL: result = left_operand >> (right_operand % 32);
      ALU_SRA: begin
        if (left_operand[31] == 1) begin
          result = ~left_operand;
          result = result >> (right_operand % 32);
          result = ~result;
        end else begin
          result = left_operand >> (right_operand % 32);
        end
      end

      // Arithmetic
      ALU_ADD: result = left_operand + right_operand;
      ALU_SUB: result = left_operand - right_operand;
      ALU_LUI: result = right_operand;

      // Logical
      ALU_AND: result = left_operand & right_operand;
      ALU_OR:  result = left_operand | right_operand;
      ALU_XOR: result = left_operand ^ right_operand;

      // Compare
      ALU_SLTU: result = left_operand < right_operand;
      ALU_SLT: begin
        if (left_operand[31] == 1 && right_operand[31] == 1) begin
          result = ((~left_operand) + 1) > ((~right_operand) + 1);
        end else if (left_operand[31] == 1 && right_operand[31] == 0) begin
          result = 1;
        end else if (left_operand[31] == 0 && right_operand[31] == 1) begin
          result = 0;
        end else begin
          result = left_operand < right_operand;
        end
      end

      default: result = left_operand + right_operand;

    endcase
  end

endmodule
