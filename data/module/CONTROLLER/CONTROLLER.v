module CONTROLLER(
  input             clock,
  input [15:0]      In,
  input             Zero,
  output reg [3:0]  alu_cmd,
  output reg        rf_write_back_en,
  output reg        write_back_result_mux,
  output reg        mem_write_en,
  output reg        rf_write_dest_mux,
  output reg        add_2_mux,
  output reg        data_2_mux,
  output reg        mem_write_mux,
  output reg        branchEn,
  output reg        jump
);
  wire [3:0] OP;
  assign OP = In[15:12];
  always@(posedge clock) begin
    alu_cmd = 0; rf_write_back_en = 0; write_back_result_mux = 0; mem_write_en = 0; rf_write_dest_mux = 0; add_2_mux = 0; data_2_mux = 0; mem_write_mux = 0; branchEn = 0; jump = 0;
    case(OP) 
      0: begin if(OP == 0) begin alu_cmd = 0; end end
      1: begin if(OP == 1) begin alu_cmd = 1;  rf_write_back_en = 1; rf_write_dest_mux = 1; end end
      2: begin if(OP == 2) begin alu_cmd = 2; rf_write_back_en = 1; rf_write_dest_mux = 1; end end
      3: begin if(OP == 3) begin alu_cmd = 3; rf_write_back_en = 1; rf_write_dest_mux = 1; end end
      4: begin if(OP == 4) begin alu_cmd = 4; rf_write_back_en = 1; rf_write_dest_mux = 1; end end
      5: begin if(OP == 5) begin alu_cmd = 5; rf_write_back_en = 1; rf_write_dest_mux = 1; end end
      6: begin if(OP == 6) begin alu_cmd = 6; rf_write_back_en = 1; rf_write_dest_mux = 1; end end
      7: begin if(OP == 7) begin alu_cmd = 7; rf_write_back_en = 1; rf_write_dest_mux = 1; end end
      8: begin if(OP == 8) begin alu_cmd = 8; rf_write_back_en = 1; rf_write_dest_mux = 1; end end
      9: begin if(OP == 9) begin alu_cmd = 9; rf_write_back_en = 1; rf_write_dest_mux = 1; end end
      10: begin if(OP == 10) begin alu_cmd = 1; rf_write_back_en = 1;  data_2_mux = 1; rf_write_dest_mux = 1; end end
      11: begin if(OP == 11) begin alu_cmd = 1; rf_write_back_en = 1;  data_2_mux = 1; rf_write_dest_mux = 1; write_back_result_mux = 1; end end
      12: begin if(OP == 12) begin alu_cmd = 1; data_2_mux = 1; add_2_mux = 1; mem_write_mux = 1; mem_write_en = 1; end end
      13: begin if(OP == 13) begin branchEn =(Zero)?1:0; end end
      14: begin if(OP == 14) begin jump = 1; end end
    endcase
  end
endmodule