module fx3_bus_controller (
input               clk,
input               rst,
input               i_master_rdy,
output  reg         o_in_path_enable,
input               i_in_path_busy,
input               i_in_path_finished,
output  reg         o_in_path_cmd_enable,
input               i_in_path_cmd_busy,
input               i_in_path_cmd_finished,
input               i_out_path_ready,
output  reg         o_out_path_enable,
input               i_out_path_busy,
input               i_out_path_finished,
output  reg         o_out_dma_buf_ready,
input               i_out_dma_buf_finished,
input               i_in_ch0_rdy,
input               i_in_ch1_rdy,
input               i_out_ch0_rdy,
input               i_out_ch1_rdy,
output  reg [1:0]   o_socket_addr
);
localparam          IDLE          = 0;
reg         [3:0]   state;
reg         [3:0]   next_state;
reg                 r_data_direction; 
reg                 r_in_buf_sel_next;
reg                 r_in_buf_sel;     
reg                 r_out_buf_sel_next;
reg                 r_out_buf_sel;    
wire                w_in_data_avail;
wire                w_out_buf_avail;
wire                w_in_path_idle;
wire                w_in_cmd_path_idle;
wire                w_out_path_idle;
assign  w_in_path_idle        = (!w_in_data_avail && !o_in_path_enable);
assign  w_in_cmd_path_idle    = !o_in_path_enable;
assign  w_out_path_idle       = !o_out_path_enable    &&
                                !i_out_path_busy      &&
                                !i_out_path_finished  &&
                                !i_out_path_ready;
assign  w_in_data_avail       = (i_in_ch0_rdy || i_in_ch1_rdy);
assign  w_out_buf_avail       = (i_out_ch0_rdy || i_out_ch1_rdy);
always @ (*) begin
  if (rst) begin
    next_state        = IDLE;
  end
  else begin
    case (state)
      IDLE: begin
      end
    endcase
  end
end
always @ (posedge clk) begin
  if (rst) begin
    state           <=  IDLE;
  end
  else begin
    state           <=  next_state;
  end
end
always @ (posedge clk) begin
  if (rst) begin
    r_data_direction      <=  0;
    r_in_buf_sel_next     <=  0;
    r_in_buf_sel          <=  0;
    r_out_buf_sel_next    <=  0;
    r_out_buf_sel         <=  0;
    o_in_path_enable      <=  0;
    o_in_path_cmd_enable  <=  0;
    o_out_path_enable     <=  0;
    o_out_dma_buf_ready   <=  0;
    o_socket_addr         <=  0;
  end
  else begin
    if (i_in_ch0_rdy && !i_in_ch1_rdy) begin
      r_in_buf_sel_next   <=  0;
    end
    else if (i_in_ch1_rdy && !i_in_ch0_rdy) begin
      r_in_buf_sel_next   <=  1;
    end
    if (i_out_ch0_rdy && !i_out_ch1_rdy) begin
      r_out_buf_sel_next  <=  0;
    end
    else if (i_out_ch1_rdy && !i_out_ch0_rdy) begin
      r_out_buf_sel_next  <=  1;
    end
    if (!o_in_path_enable && w_in_data_avail && i_master_rdy) begin
      o_socket_addr       <=  {1'b0, r_in_buf_sel_next};
      r_in_buf_sel        <=  r_in_buf_sel_next;
      o_in_path_enable    <=  1;
    end
    else if (i_in_path_finished)begin
      o_in_path_enable    <=  0;
    end
    if (i_master_rdy) begin
      o_in_path_cmd_enable  <=  1;
    end
    else if (w_in_path_idle && w_out_path_idle) begin
      o_in_path_cmd_enable  <=  0;
    end
    if (i_out_path_ready && w_in_path_idle) begin
      o_out_path_enable     <=  1;
      o_out_dma_buf_ready   <=  0;
    end
    else if (i_out_path_busy) begin
      if (w_out_buf_avail && !o_out_dma_buf_ready) begin
        o_socket_addr       <=  {1'b1, r_out_buf_sel_next};
        o_out_dma_buf_ready <=  1;
      end
      if (i_out_dma_buf_finished) begin
        o_out_dma_buf_ready <=  0;
      end
    end
    else if (i_out_path_finished) begin
      o_out_dma_buf_ready   <=  0;
      o_out_path_enable     <=  0;
    end
  end
end
endmodule