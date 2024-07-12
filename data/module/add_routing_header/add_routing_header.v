module add_routing_header
  #(parameter PORT_SEL = 0,
    parameter PROT_ENG_FLAGS = 1)
   (input clk, input reset, input clear,
    input [35:0] data_i, input src_rdy_i, output dst_rdy_o,
    output [35:0] data_o, output src_rdy_o, input dst_rdy_i);
   reg [1:0] 	  line;
   wire [1:0] 	  port_sel_bits = PORT_SEL;
   wire [15:0] 	  len = data_i[15:0];
   always @(posedge clk)
     if(reset)
       line <= PROT_ENG_FLAGS ? 0 : 1;
     else
       if(src_rdy_o & dst_rdy_i)
	 if(data_o[33])
	   line <= PROT_ENG_FLAGS ? 0 : 1;
	 else
	   if(line != 3)
	     line <= line + 1;
   assign data_o = (line == 0) ? {4'b0001, 13'b0, port_sel_bits, 1'b1, len[13:0],2'b00} :
		   (line == 1) ? {3'b000, (PROT_ENG_FLAGS ? 1'b0: 1'b1), data_i[31:0]} : 
		   data_i[35:0];
   assign dst_rdy_o = dst_rdy_i & (line != 0);
   assign src_rdy_o = src_rdy_i;
endmodule