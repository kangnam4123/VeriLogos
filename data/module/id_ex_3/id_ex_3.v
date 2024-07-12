module id_ex_3(
clk, pc_added_IDIF, cond_IDIF, inst_curr_IDIF, 
dmem_wen, rf_wen, alu_op, 
alusrc, rdest1, branch, mem2reg, rdata1, rdata2, 
extended, imm_7_0, s5_idif, s6_idif,s7_idif, inst_curr_IDEX, dmem_wen_idex, rf_wen_idex, 
alu_op_idex, alusrc_idex, rdest_idex, branch_idex, mem2reg_idex, 
rdata1_idex, rdata2_idex, extended_idex, imm_7_0_idex, 
s5_idex, s6_idex , s7_idex, pc_added_IDEX, cond_IDEX,
jal, jal_idex,
imm_12_to_16_idif, imm_12_to_16_idex,
jr,jr_idex,
exec, exec_idex,
lw, lw_idex,
stall
);
  input clk;
  input [15:0] pc_added_IDIF;
  input [3:0] cond_IDIF;
  input dmem_wen;
  input rf_wen;
  input [2:0] alu_op;
  input alusrc;
  input rdest1;
  input branch;
  input mem2reg;
  input [15:0] inst_curr_IDIF;
  input [15:0] rdata1;
  input [15:0] rdata2;
  input [15:0] extended;
  input [7:0] imm_7_0;
  input s5_idif;
  input s6_idif;
  input s7_idif;
  input jal;
  input [15:0] imm_12_to_16_idif;
  input jr;
  input exec;
  input lw;
  input stall;
  output dmem_wen_idex; reg dmem_wen_idex_temp;
  output rf_wen_idex; reg rf_wen_idex_temp;
  output [2:0] alu_op_idex; reg [2:0] alu_op_idex_temp;
  output alusrc_idex; reg alusrc_idex_temp;
  output rdest_idex; reg rdest_idex_temp;
  output branch_idex; reg branch_idex_temp;
  output mem2reg_idex; reg mem2reg_idex_temp;
  output [15:0] inst_curr_IDEX;
  output [15:0] rdata1_idex; 
  output [15:0] rdata2_idex;
  output [15:0] extended_idex;
  output [7:0] imm_7_0_idex;
  output [15:0] pc_added_IDEX; reg [15:0] pc_added_IDEX_temp;
  output [3:0] cond_IDEX;  reg [3:0] cond_IDEX_temp;
  output s5_idex; reg s5_idex_temp;
  output s6_idex; reg s6_idex_temp;
  output s7_idex; reg s7_idex_temp;
  output jal_idex;
  output [15:0] imm_12_to_16_idex;
  output jr_idex;
  output exec_idex;
  output lw_idex;
  reg [15:0] extended_idex_temp;
  reg [7:0] imm_7_0_idex_temp;
  reg [15:0] inst_curr_IDEX_temp;
  reg [15:0] rdata1_idex_temp;
  reg [15:0] rdata2_idex_temp;
  reg jal_temp;
  reg jr_temp;
  reg [15:0] imm_12_to_16_temp;
  reg exec_temp;
  reg lw_temp;
    always @ (posedge clk)
        begin
        if(stall!==1'b1) begin
        dmem_wen_idex_temp <= dmem_wen;
        rf_wen_idex_temp <= rf_wen;
        alu_op_idex_temp <= alu_op;
        alusrc_idex_temp <= alusrc;
        rdest_idex_temp <= rdest1;
        branch_idex_temp <= branch;
        mem2reg_idex_temp <= mem2reg;
        rdata1_idex_temp <= rdata1;
        rdata2_idex_temp <= rdata2;
        extended_idex_temp <= extended;
        imm_7_0_idex_temp <= imm_7_0;
        pc_added_IDEX_temp <= pc_added_IDIF;
        cond_IDEX_temp <= cond_IDIF;
        s5_idex_temp <= s5_idif;
        s6_idex_temp <= s6_idif;
        s7_idex_temp <= s7_idif;
        jal_temp <= jal;
        jr_temp <= jr;
        inst_curr_IDEX_temp <= inst_curr_IDIF;
        imm_12_to_16_temp <= imm_12_to_16_idif;
        exec_temp <= exec;
        lw_temp <= lw;
        end
        end
    assign dmem_wen_idex = dmem_wen_idex_temp;
    assign rf_wen_idex = rf_wen_idex_temp;
    assign alu_op_idex = alu_op_idex_temp;
    assign alusrc_idex = alusrc_idex_temp;
    assign rdest_idex = rdest_idex_temp;
    assign branch_idex = branch_idex_temp;
    assign mem2reg_idex = mem2reg_idex_temp;
    assign rdata1_idex = rdata1_idex_temp;
    assign rdata2_idex = rdata2_idex_temp;
    assign extended_idex = extended_idex_temp;
    assign imm_7_0_idex = imm_7_0_idex_temp;
    assign s5_idex = s5_idex_temp;
    assign s6_idex = s6_idex_temp;
    assign s7_idex = s7_idex_temp;
    assign inst_curr_IDEX = inst_curr_IDEX_temp;
    assign pc_added_IDEX = pc_added_IDEX_temp;
    assign cond_IDEX = cond_IDEX_temp; 
    assign jal_idex = jal_temp;
    assign jr_idex = jr_temp;
    assign imm_12_to_16_idex = imm_12_to_16_temp;
    assign exec_idex = exec_temp;
    assign lw_idex = lw_temp;
endmodule