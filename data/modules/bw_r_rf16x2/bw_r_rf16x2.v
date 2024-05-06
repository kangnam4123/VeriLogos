module bw_r_rf16x2(word_wen, wen, ren, wr_addr, rd_addr, wr_data,
	rd_data, clk, rd_clk, reset_l);
  input [3:0] word_wen;
  input	      wen;
  input	      ren;
  input	[3:0] wr_addr;
  input [3:0] rd_addr;
  input [7:0] wr_data;
  output [7:0] rd_data;
  input	clk;
  input	rd_clk;
  input reset_l;
  reg	[7:0] rd_data_temp;
  reg [1:0] inq_ary0[15:0];
  reg [1:0] inq_ary1[15:0];
  reg [1:0] inq_ary2[15:0];
  reg [1:0] inq_ary3[15:0];
  always @(posedge clk) begin
    if(reset_l & wen & word_wen[0])
      inq_ary0[wr_addr] = {wr_data[4],wr_data[0]};
    if(reset_l & wen & word_wen[1])
      inq_ary1[wr_addr] = {wr_data[5],wr_data[1]};
    if(reset_l & wen & word_wen[2])
      inq_ary2[wr_addr] = {wr_data[6],wr_data[2]};
    if(reset_l & wen & word_wen[3])
      inq_ary3[wr_addr] = {wr_data[7],wr_data[3]};
  end
  always @(negedge rd_clk) begin
    if (~reset_l) begin
      rd_data_temp = 8'b0;
    end else if(ren == 1'b1) begin
        rd_data_temp = {inq_ary3[rd_addr], inq_ary2[rd_addr], inq_ary1[rd_addr], inq_ary0[rd_addr]};
    end
  end
  assign rd_data = {rd_data_temp[7], rd_data_temp[5], rd_data_temp[3], 
		rd_data_temp[1], rd_data_temp[6], rd_data_temp[4], 
		rd_data_temp[2], rd_data_temp[0]};
endmodule