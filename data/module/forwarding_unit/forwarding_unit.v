module forwarding_unit
  ( 
  rf_waddr_exmem,
  rf_waddr_memwb,
  inst_curr_IDEX_7_4_rs,
  inst_curr_IDEX_3_0_rt,
  inst_curr_IDEX_11_8_rd,
  rf_wen_exmem,
  rf_wen_memwb,
  mem2reg_memwb,
  mem2reg_exmem,
  dmem_wen_idex,
  forwardA,
  forwardB,
  rdata2_sw_fcontrol,
  );
  input [3:0] rf_waddr_exmem;
  input [3:0] rf_waddr_memwb;
  input [3:0] inst_curr_IDEX_7_4_rs;
  input [3:0] inst_curr_IDEX_3_0_rt;
  input [3:0] inst_curr_IDEX_11_8_rd;
  input rf_wen_exmem;
  input rf_wen_memwb;
  input mem2reg_memwb;
  input mem2reg_exmem;
  input dmem_wen_idex;
  output [1:0] forwardA;
  output [1:0] forwardB;
  output [1:0] rdata2_sw_fcontrol;
  assign forwardA = ((rf_wen_exmem === 1'b1) && (!(rf_waddr_exmem === 4'b0000)) 
              && (rf_waddr_exmem === inst_curr_IDEX_7_4_rs))? ((mem2reg_exmem!==1'b1)? 2'b10 : 2'b00) : 
              (((rf_wen_memwb === 1'b1) && (!(rf_waddr_memwb === 4'b0000))
              && (!(rf_waddr_exmem === inst_curr_IDEX_7_4_rs)) 
              && (rf_waddr_memwb === inst_curr_IDEX_7_4_rs)
              ) ? ((mem2reg_memwb!==1'b1)? 2'b01: 2'b00) : 2'b00);
  assign forwardB =  ((rf_wen_exmem === 1'b1) && (!(rf_waddr_exmem === 4'b0000)) 
              && (rf_waddr_exmem === inst_curr_IDEX_3_0_rt))? ((mem2reg_exmem!==1'b1)? 2'b10 : 2'b00) :  
              (((rf_wen_memwb === 1'b1) && (!(rf_waddr_memwb === 4'b0000))
              && (!(rf_waddr_exmem === inst_curr_IDEX_3_0_rt)) 
              && (rf_waddr_memwb === inst_curr_IDEX_3_0_rt)
              ) ? ((mem2reg_memwb!==1'b1)? 2'b01: 2'b00) : 2'b00);
  assign rdata2_sw_fcontrol = ((dmem_wen_idex === 1'b0) && (!(rf_waddr_exmem === 4'b0000))
                               && (rf_waddr_exmem === inst_curr_IDEX_11_8_rd)) ? ((mem2reg_exmem!==1'b1)? 2'b10: 2'b00) :
                               (((dmem_wen_idex === 1'b0) && (!(rf_waddr_memwb === 4'b0000))
                               && (rf_waddr_memwb === inst_curr_IDEX_11_8_rd)) ? ((mem2reg_memwb!==1'b1)? 2'b01 : 2'b00) : 2'b00);
endmodule