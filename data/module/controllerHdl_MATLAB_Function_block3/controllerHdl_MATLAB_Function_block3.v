module controllerHdl_MATLAB_Function_block3
          (
           CLK_IN,
           reset,
           enb_1_2000_0,
           u,
           y
          );
  input   CLK_IN;
  input   reset;
  input   enb_1_2000_0;
  input   signed [18:0] u;  
  output  signed [18:0] y;  
  reg signed [18:0] y_1;  
  reg  sel;
  reg [15:0] count_n;  
  reg [15:0] count_p;  
  reg signed [18:0] u_n1;  
  reg signed [18:0] u_filter_p;  
  reg signed [18:0] u_filter_n;  
  reg  sel_next;
  reg [15:0] count_n_next;  
  reg [15:0] count_p_next;  
  reg signed [18:0] u_n1_next;  
  reg signed [18:0] u_filter_p_next;  
  reg signed [18:0] u_filter_n_next;  
  reg signed [37:0] a1_1;  
  reg signed [37:0] b1_1;  
  reg signed [37:0] c1_1;  
  reg signed [37:0] a1_0_1;  
  reg signed [37:0] b1_0_1;  
  reg signed [37:0] c1_0_1;  
  reg  sel_temp_1;
  reg signed [18:0] u_filter_p_temp_1;  
  reg signed [18:0] u_filter_n_temp_1;  
  always @(posedge CLK_IN)
    begin : MATLAB_Function_process
      if (reset == 1'b1) begin
        sel <= 1'b0;
        u_n1 <= 19'sb0000000000000000000;
        u_filter_p <= 19'sb0000000000000000000;
        u_filter_n <= 19'sb0000000000000000000;
        count_n <= 16'b0000000000000000;
        count_p <= 16'b0000000000000000;
      end
      else if (enb_1_2000_0) begin
        sel <= sel_next;
        count_n <= count_n_next;
        count_p <= count_p_next;
        u_n1 <= u_n1_next;
        u_filter_p <= u_filter_p_next;
        u_filter_n <= u_filter_n_next;
      end
    end
  always @(u, sel, count_n, count_p, u_n1, u_filter_p, u_filter_n) begin
    sel_temp_1 = sel;
    u_filter_p_temp_1 = u_filter_p;
    u_filter_n_temp_1 = u_filter_n;
    count_n_next = count_n;
    count_p_next = count_p;
    if ((u < 19'sb0000000000000000000) && (u_n1 > 19'sb0000000000000000000)) begin
      sel_temp_1 = count_p > count_n;
      count_n_next = 16'b0000000000000000;
      count_p_next = 16'b0000000000000000;
    end
    else if (u > 19'sb0000000000000000000) begin
      a1_0_1 = 14336 * u_filter_p;
      b1_0_1 = {{8{u[18]}}, {u, 11'b00000000000}};
      c1_0_1 = a1_0_1 + b1_0_1;
      if (((c1_0_1[37] == 1'b0) && (c1_0_1[36:32] != 5'b00000)) || ((c1_0_1[37] == 1'b0) && (c1_0_1[32:14] == 19'sb0111111111111111111))) begin
        u_filter_p_temp_1 = 19'sb0111111111111111111;
      end
      else if ((c1_0_1[37] == 1'b1) && (c1_0_1[36:32] != 5'b11111)) begin
        u_filter_p_temp_1 = 19'sb1000000000000000000;
      end
      else begin
        u_filter_p_temp_1 = c1_0_1[32:14] + $signed({1'b0, c1_0_1[13]});
      end
      count_p_next = count_p + 1;
    end
    else begin
      a1_1 = 14336 * u_filter_n;
      b1_1 = {{8{u[18]}}, {u, 11'b00000000000}};
      c1_1 = a1_1 + b1_1;
      if (((c1_1[37] == 1'b0) && (c1_1[36:32] != 5'b00000)) || ((c1_1[37] == 1'b0) && (c1_1[32:14] == 19'sb0111111111111111111))) begin
        u_filter_n_temp_1 = 19'sb0111111111111111111;
      end
      else if ((c1_1[37] == 1'b1) && (c1_1[36:32] != 5'b11111)) begin
        u_filter_n_temp_1 = 19'sb1000000000000000000;
      end
      else begin
        u_filter_n_temp_1 = c1_1[32:14] + $signed({1'b0, c1_1[13]});
      end
      count_n_next = count_n + 1;
    end
    u_n1_next = u;
    if (sel_temp_1) begin
      y_1 = u_filter_p_temp_1;
    end
    else begin
      y_1 = u_filter_n_temp_1;
    end
    sel_next = sel_temp_1;
    u_filter_p_next = u_filter_p_temp_1;
    u_filter_n_next = u_filter_n_temp_1;
  end
  assign y = y_1;
endmodule