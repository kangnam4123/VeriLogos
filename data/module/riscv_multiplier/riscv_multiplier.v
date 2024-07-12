module riscv_multiplier
(
     input           clk_i
    ,input           rst_i
    ,input           opcode_valid_i
    ,input           inst_mul
    ,input           inst_mulh
    ,input           inst_mulhsu
    ,input           inst_mulhu
    ,input  [ 31:0]  opcode_ra_operand_i
    ,input  [ 31:0]  opcode_rb_operand_i
    ,input           hold_i
    ,output [ 31:0]  writeback_value_o
);
localparam MULT_STAGES = 2; 
reg  [31:0]  result_e2_q;
reg  [31:0]  result_e3_q;
reg [32:0]   operand_a_e1_q;
reg [32:0]   operand_b_e1_q;
reg          mulhi_sel_e1_q;
wire [64:0]  mult_result_w;
reg  [32:0]  operand_b_r;
reg  [32:0]  operand_a_r;
reg  [31:0]  result_r;
wire mult_inst_w    = (inst_mul)     || 
                      (inst_mulh)    ||
                      (inst_mulhsu)  ||
                      (inst_mulhu);
always @ *
begin
    if (inst_mulhsu)
        operand_a_r = {opcode_ra_operand_i[31], opcode_ra_operand_i[31:0]};
    else if (inst_mulh)
        operand_a_r = {opcode_ra_operand_i[31], opcode_ra_operand_i[31:0]};
    else 
        operand_a_r = {1'b0, opcode_ra_operand_i[31:0]};
end
always @ *
begin
    if (inst_mulhsu)
        operand_b_r = {1'b0, opcode_rb_operand_i[31:0]};
    else if (inst_mulh)
        operand_b_r = {opcode_rb_operand_i[31], opcode_rb_operand_i[31:0]};
    else 
        operand_b_r = {1'b0, opcode_rb_operand_i[31:0]};
end
always @(posedge clk_i)
if (rst_i)
begin
    operand_a_e1_q <= 33'b0;
    operand_b_e1_q <= 33'b0;
    mulhi_sel_e1_q <= 1'b0;
end
else if (hold_i)
    ;
else if (opcode_valid_i && mult_inst_w)
begin
    operand_a_e1_q <= operand_a_r;
    operand_b_e1_q <= operand_b_r;
    mulhi_sel_e1_q <= ~(inst_mul);
end
else
begin
    operand_a_e1_q <= 33'b0;
    operand_b_e1_q <= 33'b0;
    mulhi_sel_e1_q <= 1'b0;
end
assign mult_result_w = {{ 32 {operand_a_e1_q[32]}}, operand_a_e1_q}*{{ 32 {operand_b_e1_q[32]}}, operand_b_e1_q};
always @ *
begin
    result_r = mulhi_sel_e1_q ? mult_result_w[63:32] : mult_result_w[31:0];
end
always @(posedge clk_i)
if (rst_i)
    result_e2_q <= 32'b0;
else if (~hold_i)
    result_e2_q <= result_r;
always @(posedge clk_i)
if (rst_i)
    result_e3_q <= 32'b0;
else if (~hold_i)
    result_e3_q <= result_e2_q;
assign writeback_value_o  = (MULT_STAGES == 3) ? result_e3_q : result_e2_q;
endmodule