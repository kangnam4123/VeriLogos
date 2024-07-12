module m6502_alu(
                 input wire  [7 : 0] operation,
                 input wire  [7 : 0] op_a,
                 input wire  [7 : 0] op_b,
                 input wire          carry_in,
                 output wire [7 : 0] result,
                 output wire         carry,
                 output wire         zero,
                 output wire         overflow
                );
  localparam OP_AND = 8'h01;
  localparam OP_OR  = 8'h02;
  localparam OP_XOR = 8'h03;
  localparam OP_NOT = 8'h04;
  localparam OP_ASL = 8'h11;
  localparam OP_ROL = 8'h12;
  localparam OP_ASR = 8'h13;
  localparam OP_ROR = 8'h14;
  localparam OP_ADD = 8'h21;
  localparam OP_INC = 8'h22;
  localparam OP_SUB = 8'h23;
  localparam OP_DEC = 8'h24;
  localparam OP_CMP = 8'h31;
  reg [7 : 0] tmp_result;
  reg         tmp_carry;
  reg         tmp_zero;
  reg         tmp_overflow;
  assign result   = tmp_result;
  assign carry    = tmp_carry;
  assign zero     = tmp_zero;
  assign overflow = tmp_overflow;
  always @*
    begin : alu
      reg [8 : 0] tmp_add;
      tmp_result   = 8'h0;
      tmp_carry    = 0;
      tmp_zero     = 0;
      tmp_overflow = 0;
      case (operation)
        OP_AND:
          begin
            tmp_result = op_a & op_b;
          end
        OP_OR:
          begin
            tmp_result = op_a | op_b;
          end
        OP_XOR:
          begin
            tmp_result = op_a ^ op_b;
          end
        OP_NOT:
          begin
            tmp_result = ~op_a;
          end
        OP_ASL:
          begin
            tmp_result = {op_a[6 : 0], carry_in};
            tmp_carry  = op_a[7];
          end
        OP_ROL:
          begin
            tmp_result = {op_a[6 : 0], op_a[7]};
          end
        OP_ASR:
          begin
            tmp_result = {carry_in, op_a[7 : 1]};
            tmp_carry  = op_a[0];
          end
        OP_ROR:
          begin
            tmp_result = {op_a[0], op_a[7 : 1]};
          end
        OP_ADD:
          begin
            tmp_add = op_a + op_b + carry_in;
            tmp_result = tmp_add[7 : 0];
            tmp_carry  = tmp_add[8];
          end
        OP_INC:
          begin
            tmp_add = op_a + 1'b1;
            tmp_result = tmp_add[7 : 0];
            tmp_carry  = tmp_add[8];
          end
        OP_SUB:
          begin
            tmp_result = op_a - op_b;
            if (tmp_result == 8'h00)
              tmp_zero = 1;
          end
        OP_DEC:
          begin
            tmp_result = op_a - 1'b1;
          end
        OP_CMP:
          begin
            if (op_a == op_b)
              tmp_zero = 1;
          end
        default:
          begin
          end
      endcase 
    end 
endmodule