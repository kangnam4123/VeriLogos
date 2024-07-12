module sprdma
(
  input  wire        clk_in,         
  input  wire        rst_in,         
  input  wire [15:0] cpumc_a_in,     
  input  wire [ 7:0] cpumc_din_in,   
  input  wire [ 7:0] cpumc_dout_in,  
  input  wire        cpu_r_nw_in,    
  output wire        active_out,     
  output reg  [15:0] cpumc_a_out,    
  output reg  [ 7:0] cpumc_d_out,    
  output reg         cpumc_r_nw_out  
);
localparam [1:0] S_READY    = 2'h0,
                 S_ACTIVE   = 2'h1,
                 S_COOLDOWN = 2'h2;
reg [ 1:0] q_state, d_state; 
reg [15:0] q_addr,  d_addr;  
reg [ 1:0] q_cnt,   d_cnt;   
reg [ 7:0] q_data,  d_data;  
always @(posedge clk_in)
  begin
    if (rst_in)
      begin
        q_state <= S_READY;
        q_addr  <= 16'h0000;
        q_cnt   <= 2'h0;
        q_data  <= 8'h00;
      end
    else
      begin
        q_state <= d_state;
        q_addr  <= d_addr;
        q_cnt   <= d_cnt;
        q_data  <= d_data;
      end
  end
always @*
  begin
    d_state = q_state;
    d_addr  = q_addr;
    d_cnt   = q_cnt;
    d_data  = q_data;
    cpumc_a_out    = 16'h00;
    cpumc_d_out    = 8'h00;
    cpumc_r_nw_out = 1'b1;
    if (q_state == S_READY)
      begin
        if ((cpumc_a_in == 16'h4014) && !cpu_r_nw_in)
          begin
            d_state = S_ACTIVE;
            d_addr  = { cpumc_din_in, 8'h00 };
          end
      end
    else if (q_state == S_ACTIVE)
      begin
        case (q_cnt)
          2'h0:
            begin
              cpumc_a_out = q_addr;
              d_cnt       = 2'h1;
            end
          2'h1:
            begin
              cpumc_a_out = q_addr;
              d_data      = cpumc_dout_in;
              d_cnt       = 2'h2;
            end
          2'h2:
            begin
              cpumc_a_out    = 16'h2004;
              cpumc_d_out    = q_data;
              cpumc_r_nw_out = 1'b0;
              d_cnt          = 2'h0;
              if (q_addr[7:0] == 8'hff)
                d_state = S_COOLDOWN;
              else
                d_addr = q_addr + 16'h0001;
            end
        endcase
      end
    else if (q_state == S_COOLDOWN)
      begin
        if (cpu_r_nw_in)
          d_state = S_READY;
      end
  end
assign active_out = (q_state == S_ACTIVE);
endmodule