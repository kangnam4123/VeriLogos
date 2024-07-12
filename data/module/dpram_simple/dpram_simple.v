module dpram_simple(clock,
	            address_a, wrdata_a, wren_a, rddata_a,
                    address_b, wrdata_b, wren_b, rddata_b);
   parameter DATA_WIDTH =  8;
   parameter ADDR_WIDTH =  7;
   parameter INIT_FILE  = "somefile"; 
   parameter DEBUG      = 0;
   input                         clock;
   input      [ADDR_WIDTH-1:0]   address_a;
   input      [DATA_WIDTH-1:0]   wrdata_a;
   input                         wren_a;
   output reg [DATA_WIDTH-1:0]   rddata_a;
   input      [ADDR_WIDTH-1:0]   address_b;
   input      [DATA_WIDTH-1:0]   wrdata_b;
   input                         wren_b;
   output reg [DATA_WIDTH-1:0]   rddata_b;
   reg [DATA_WIDTH-1:0] ram[(1 << ADDR_WIDTH)-1:0];
   always @(posedge clock) begin
      if (wren_a)
         ram[address_a] <= wrdata_a;
      rddata_a <= ram[address_a];
   end
   always @(posedge clock) begin
      if (wren_b)
         ram[address_b] <= wrdata_b;
      rddata_b <= ram[address_b];
   end
endmodule