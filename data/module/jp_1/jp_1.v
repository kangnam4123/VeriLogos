module jp_1
(
  input  wire        clk,       
  input  wire        rst,       
  input  wire        wr,        
  input  wire [15:0] addr,      
  input  wire        din,       
  input  wire        jp_data1,  
  input  wire        jp_data2,  
  output wire        jp_clk,    
  output wire        jp_latch,  
  output reg  [ 7:0] dout       
);
reg [7:0] q_jp1_state, d_jp1_state;
reg [7:0] q_jp2_state, d_jp2_state;
reg       q_jp_clk,    d_jp_clk;
reg       q_jp_latch,  d_jp_latch;
reg [8:0] q_cnt,       d_cnt;
always @(posedge clk)
  begin
    if (rst)
      begin
        q_jp1_state <= 8'h00;
        q_jp2_state <= 8'h00;
        q_jp_clk    <= 1'b0;
        q_jp_latch  <= 1'b0;
        q_cnt       <= 9'h00;
      end
    else
      begin
        q_jp1_state <= d_jp1_state;
        q_jp2_state <= d_jp2_state;
        q_jp_clk    <= d_jp_clk;
        q_jp_latch  <= d_jp_latch;
        q_cnt       <= d_cnt;
      end
  end
wire [2:0] state_idx;
always @*
  begin
    d_jp1_state = q_jp1_state;
    d_jp2_state = q_jp2_state;
    d_jp_clk    = q_jp_clk;
    d_jp_latch  = q_jp_latch;
    d_cnt = q_cnt + 9'h001;
    if (q_cnt[5:1] == 5'h00)
      begin
        d_jp1_state[state_idx] = ~jp_data1;
        d_jp2_state[state_idx] = ~jp_data2;
        if (q_cnt[8:1] == 8'h00)
          d_jp_latch = 1'b1;
        else
          d_jp_clk = 1'b1;
      end
    else if (q_cnt[5:1] == 5'h10)
      begin
        d_jp_clk   = 1'b0;
        d_jp_latch = 1'b0;
      end
  end
assign state_idx = q_cnt[8:6] - 3'h1;
assign jp_latch  = q_jp_latch;
assign jp_clk    = q_jp_clk;
localparam [15:0] JOYPAD1_MMR_ADDR = 16'h4016;
localparam [15:0] JOYPAD2_MMR_ADDR = 16'h4017;
localparam S_STROBE_WROTE_0 = 1'b0,
           S_STROBE_WROTE_1 = 1'b1;
reg [15:0] q_addr;
reg [ 8:0] q_jp1_read_state, d_jp1_read_state;
reg [ 8:0] q_jp2_read_state, d_jp2_read_state;
reg        q_strobe_state,   d_strobe_state;
always @(posedge clk)
  begin
    if (rst)
      begin
        q_addr           <= 16'h0000;
        q_jp1_read_state <= 9'h000;
        q_jp2_read_state <= 9'h000;
        q_strobe_state   <= S_STROBE_WROTE_0;
      end
    else
      begin
        q_addr           <= addr;
        q_jp1_read_state <= d_jp1_read_state;
        q_jp2_read_state <= d_jp2_read_state;
        q_strobe_state   <= d_strobe_state;
      end
  end
always @*
  begin
    dout = 8'h00;
    d_jp1_read_state = q_jp1_read_state;
    d_jp2_read_state = q_jp2_read_state;
    d_strobe_state   = q_strobe_state;
    if (addr[15:1] == JOYPAD1_MMR_ADDR[15:1])
      begin
        dout = { 7'h00, ((addr[0]) ? q_jp2_read_state[0] : q_jp1_read_state[0]) };
        if (addr != q_addr)
          begin
            if (wr && !addr[0])
              begin
                if ((q_strobe_state == S_STROBE_WROTE_0) && (din == 1'b1))
                  begin
                    d_strobe_state = S_STROBE_WROTE_1;
                  end
                else if ((q_strobe_state == S_STROBE_WROTE_1) && (din == 1'b0))
                  begin
                    d_strobe_state = S_STROBE_WROTE_0;
                    d_jp1_read_state = { q_jp1_state, 1'b0 };
                    d_jp2_read_state = { q_jp2_state, 1'b0 };
                  end
              end
            else if (!wr && !addr[0])
              d_jp1_read_state = { 1'b1, q_jp1_read_state[8:1] };
            else if (!wr && addr[0])
              d_jp2_read_state = { 1'b1, q_jp2_read_state[8:1] };
          end
      end
  end
endmodule