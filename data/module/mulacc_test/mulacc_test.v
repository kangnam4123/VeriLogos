module mulacc_test(
                   input wire           clk,
                   input wire           reset_n,
                   input wire           cs,
                   input wire           we,
                   input wire  [5 : 0]  address,
                   input wire  [25 : 0] write_data,
                   output wire [58 : 0] read_data
                   );
  localparam ADDR_A0   = 8'h00;
  localparam ADDR_A4   = 8'h04;
  localparam ADDR_B0   = 8'h10;
  localparam ADDR_B4   = 8'h14;
  localparam ADDR_RES0 = 8'h20;
  localparam ADDR_RES4 = 8'h24;
  reg [25 : 0] a_mem [0 : 4];
  reg          a_mem_we;
  reg [25 : 0] b_mem [0 : 4];
  reg          b_mem_we;
  reg [58 : 0] p0_reg;
  reg [58 : 0] p0_new;
  reg [28 : 0] b51_reg;
  reg [28 : 0] b51_new;
  reg [28 : 0] b52_reg;
  reg [28 : 0] b52_new;
  reg [28 : 0] b53_reg;
  reg [28 : 0] b53_new;
  reg [28 : 0] b54_reg;
  reg [28 : 0] b54_new;
  reg [53 : 0] prim0_reg;
  reg [53 : 0] prim0_new;
  reg [53 : 0] prim1_reg;
  reg [53 : 0] prim1_new;
  reg [53 : 0] prim2_reg;
  reg [53 : 0] prim2_new;
  reg [53 : 0] prim3_reg;
  reg [53 : 0] prim3_new;
  reg [53 : 0] prim4_reg;
  reg [53 : 0] prim4_new;
  reg [58 : 0] tmp_read_data;
  assign read_data = tmp_read_data;
  always @ (posedge clk)
    begin : reg_update
      if (!reset_n)
        begin
          b51_reg   <= 29'h0;
          b52_reg   <= 29'h0;
          b53_reg   <= 29'h0;
          b54_reg   <= 29'h0;
          prim0_reg <= 54'h0;
          prim1_reg <= 54'h0;
          prim2_reg <= 54'h0;
          prim3_reg <= 54'h0;
          prim4_reg <= 54'h0;
          p0_reg    <= 59'h0;
        end
      else
        begin
          b51_reg <= b51_new;
          b52_reg <= b52_new;
          b53_reg <= b53_new;
          b54_reg <= b54_new;
          prim0_reg <= prim0_new;
          prim1_reg <= prim1_new;
          prim2_reg <= prim2_new;
          prim3_reg <= prim3_new;
          prim4_reg <= prim4_new;
          p0_reg <= p0_new;
          if (a_mem_we)
            a_mem[address[2:0]] <= write_data;
          if (b_mem_we)
            b_mem[address[2:0]] <= write_data;
        end
    end 
  always @*
    begin : mac_logic
      reg [28 : 0] b51;
      reg [28 : 0] b52;
      reg [28 : 0] b53;
      reg [28 : 0] b54;
      b51_new = {b_mem[1], 2'b0} + b_mem[1];
      b52_new = {b_mem[2], 2'b0} + b_mem[2];
      b53_new = {b_mem[3], 2'b0} + b_mem[3];
      b54_new = {b_mem[4], 2'b0} + b_mem[4];
      prim0_new = a_mem[0] * b_mem[0];
      prim1_new = a_mem[1] * b54_reg;
      prim2_new = a_mem[2] * b53_reg;
      prim3_new = a_mem[3] * b52_reg;
      prim4_new = a_mem[4] * b51_reg;
      p0_new = prim0_reg + prim1_reg + prim2_reg +
               prim3_reg + prim4_reg;
    end
  always @*
    begin : addr_decoder
      a_mem_we      = 0;
      b_mem_we      = 0;
      tmp_read_data = 59'h0;
      if (cs)
        begin
          if (we)
            begin
              if ((address >= ADDR_A0) && (address <= ADDR_A4))
                a_mem_we = 1;
              if ((address >= ADDR_B0) && (address <= ADDR_B4))
                b_mem_we = 1;
            end
          else
            begin
              if ((address >= ADDR_RES0) && (address <= ADDR_RES4))
                tmp_read_data = p0_reg;
            end
        end
    end 
endmodule