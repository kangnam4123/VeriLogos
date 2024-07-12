module blockmem1r1w(
                    input wire           clk,
                    input wire  [07 : 0] read_addr,
                    output wire [31 : 0] read_data,
                    input wire           wr,
                    input wire  [07 : 0] write_addr,
                    input wire  [31 : 0] write_data
                   );
  reg [31 : 0] mem [0 : 255];
  reg [31 : 0] tmp_read_data;
  assign read_data = tmp_read_data;
  always @ (posedge clk)
    begin : reg_mem
      if (wr)
        mem[write_addr] <= write_data;
      tmp_read_data <= mem[read_addr];
    end
endmodule