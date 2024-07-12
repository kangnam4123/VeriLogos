module sd_dev_platform_cocotb (
input               clk,
input               rst,
input               ddr_en,
output              o_sd_clk,
output              o_sd_clk_x2,
output  reg         o_locked,
input               i_sd_cmd_dir,
output              o_sd_cmd_in,
input               i_sd_cmd_out,
input               i_sd_data_dir,
output  reg   [7:0] o_sd_data_in,
input         [7:0] i_sd_data_out,
input               i_phy_clk,
inout               io_phy_sd_cmd,
inout         [3:0] io_phy_sd_data
);
reg                   prev_clk_edge;
wire          [7:0]   data_out;
reg           [3:0]   lock_count;
wire          [7:0]   sd_data_in;
reg           [3:0]   top_nibble;
wire          [3:0]   in_remap;
wire          [3:0]   out_remap;
reg       posedge_clk;
reg       negedge_clk;
assign  o_sd_clk      = i_phy_clk;
assign  o_sd_clk_x2   = clk;
assign  io_phy_sd_cmd = i_sd_cmd_dir  ? i_sd_cmd_out : 1'hZ;
assign  o_sd_cmd_in   = io_phy_sd_cmd;
assign  io_phy_sd_data= i_sd_data_dir ? data_out: 8'hZ;
assign  out_remap     = posedge_clk   ? { i_sd_data_out[0],
                                          i_sd_data_out[1],
                                          i_sd_data_out[2],
                                          i_sd_data_out[3]} :
                                        { i_sd_data_out[4],
                                          i_sd_data_out[5],
                                          i_sd_data_out[6],
                                          i_sd_data_out[7]};
assign  data_out      = out_remap;
assign  in_remap      =                 { io_phy_sd_data[3],
                                          io_phy_sd_data[2],
                                          io_phy_sd_data[1],
                                          io_phy_sd_data[0]};
always @ (posedge clk) begin
  posedge_clk       <=  0;
  negedge_clk       <=  0;
  if (i_phy_clk && !prev_clk_edge)
    posedge_clk   <=  1;
  if (!i_phy_clk && prev_clk_edge)
    negedge_clk   <=  1;
  prev_clk_edge     <=  i_phy_clk;
end
always @ (posedge clk) begin
  if (rst) begin
    o_sd_data_in    <=  0;
    top_nibble      <=  0;
  end
  else begin
    if (negedge_clk) begin
      top_nibble    <=  in_remap;
    end
    if (posedge_clk) begin
      o_sd_data_in  <=  {top_nibble, in_remap};
    end
  end
end
always @ (posedge clk) begin
  if (rst) begin
    o_locked      <=  0;
    lock_count    <=  0;
  end
  else begin
    if (lock_count < 4'hF) begin
      lock_count  <=  lock_count + 1;
    end
    else begin
      o_locked    <=  1;
    end
  end
end
endmodule