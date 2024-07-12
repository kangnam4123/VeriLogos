module i2s_reader_phy (
  input               rst,
  input               clk,
  output      [31:0]  debug,
  input               i_enable,
  input       [23:0]  i_min_read_size,
  input       [23:0]  i_wfifo_size,
  input       [1:0]   i_wfifo_ready,
  output  reg [1:0]   o_wfifo_activate  = 2'b0,
  output  reg         o_wfifo_strobe    = 1'b0,
  output  reg [31:0]  o_wfifo_data      = 32'h0,
  input               i_i2s_lr,
  input               i_i2s_data
);
localparam            IDLE          = 4'h0;
localparam            READ          = 4'h1;
reg           [3:0]   state         = IDLE;
reg           [31:0]  read_word     = 32'h0;
reg           [23:0]  r_count       = 24'h0;
reg                   r_prev_i2s_lr = 1'b0;
assign  debug[0]      = i_i2s_lr;
assign  debug[1]      = i_i2s_data;
assign  debug[2]      = i_enable;
assign  debug[4:3]    = i_wfifo_ready;
assign  debug[6:5]    = o_wfifo_activate;
assign  debug[7]      = o_wfifo_strobe;
assign  debug[11:8]   = state;
always @ (posedge clk) begin
  if (rst) begin
    state                     <=  IDLE;
    o_wfifo_activate          <=  2'b0;
    o_wfifo_strobe            <=  1'b0;
    o_wfifo_data              <=  32'h0;
    r_count                   <=  0;
    r_prev_i2s_lr             <=  0;
  end
  else begin
    o_wfifo_strobe            <=  0;
    if ((state == READ) && ((i_wfifo_ready > 0) && (o_wfifo_activate == 0))) begin
      r_count                 <=  0;
      if (i_wfifo_ready[0]) begin
        o_wfifo_activate[0]   <=  1;
      end                     
      else begin              
        o_wfifo_activate[1]   <=  1;
      end                     
    end                       
    case (state)              
      IDLE: begin             
        if (i_enable) begin  
          state               <=  READ;
          o_wfifo_activate    <=  0;
        end
      end
      READ: begin
        if (!i_enable) begin
          state               <=  IDLE;
        end
        else begin
          if (r_count < i_wfifo_size) begin
            if (i_i2s_lr != r_prev_i2s_lr) begin
              o_wfifo_data    <=  {r_prev_i2s_lr, 7'h0, read_word[23:0]};
              o_wfifo_strobe  <=  1;
              r_count         <=  r_count + 1;
            end
          end
          else begin
            o_wfifo_activate  <=  0;
          end
          read_word           <=  {read_word[30:0] << 1, i_i2s_data};
        end
      end
      default: begin
        state                 <=  IDLE;
      end
    endcase
  end
  r_prev_i2s_lr               <=  i_i2s_lr;
end
endmodule