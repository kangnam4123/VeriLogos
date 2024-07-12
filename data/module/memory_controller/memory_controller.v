module memory_controller
  (
   clock,
   reset_b,
   ext_cs_b,
   cpu_rnw,
   cpu_clken,
   cpu_addr,
   cpu_dout,
   ext_dout,
   ram_cs_b,
   ram_oe_b,
   ram_we_b,
   ram_data_in,
   ram_data_out,
   ram_data_oe,
   ram_addr
   );
   parameter DSIZE        = 32;
   parameter ASIZE        = 20;
   input                 clock;
   input                 reset_b;
   input                 ext_cs_b;
   input                 cpu_rnw;
   output                cpu_clken;
   input [ASIZE-1:0]     cpu_addr;
   input [DSIZE-1:0]     cpu_dout;
   output [DSIZE-1:0]    ext_dout;
   output                ram_cs_b;
   output                ram_oe_b;
   output                ram_we_b;
   output [17:0]         ram_addr;
   input  [15:0]         ram_data_in;
   output [15:0]         ram_data_out;
   output                ram_data_oe;
   wire                  ext_a_lsb;
   reg                   ext_we_b;
   reg [15:0]            ram_data_last;
   reg [1:0]             count;
   always @(posedge clock)
     if (!reset_b)
       count <= 0;
     else if (!ext_cs_b || count > 0)
       count <= count + 1;
   assign cpu_clken = !(!ext_cs_b && count < 3);
   assign ext_a_lsb = count[1];
   always @(posedge clock)
      if (!cpu_rnw && !ext_cs_b && !count[0])
         ext_we_b <= 1'b0;
      else
         ext_we_b <= 1'b1;
   always @(posedge clock)
     if (count[0] == 1'b1)
       ram_data_last <= ram_data_in;
   assign ext_dout = { ram_data_in, ram_data_last };
   assign ram_addr = {cpu_addr[16:0], ext_a_lsb};
   assign ram_cs_b = ext_cs_b;
   assign ram_oe_b = !cpu_rnw;
   assign ram_we_b = ext_we_b;
   assign ram_data_oe = !cpu_rnw;
   assign ram_data_out  = ext_a_lsb == 1 ? cpu_dout[31:16]  :
                                           cpu_dout[15:0]   ;
endmodule