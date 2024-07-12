module etx_remap (
   emesh_access_out, emesh_packet_out,
   clk, reset, emesh_access_in, emesh_packet_in, remap_en,
   remap_bypass, etx_rd_wait, etx_wr_wait
   );
   parameter AW = 32;
   parameter DW = 32;
   parameter PW = 104;
   parameter ID = 12'h808;
   input clk;
   input reset;
   input          emesh_access_in;
   input [PW-1:0] emesh_packet_in;
   input 	  remap_en;             
   input 	  remap_bypass;         
   output 	   emesh_access_out;
   output [PW-1:0] emesh_packet_out;
   input 	   etx_rd_wait;
   input 	   etx_wr_wait;
   wire [31:0] 	   addr_in;
   wire [31:0] 	   addr_remap;
   wire [31:0] 	   addr_out;
   wire 	   write_in;
   reg 		   emesh_access_out;
   reg [PW-1:0]    emesh_packet_out;
   assign addr_in[31:0]   =  emesh_packet_in[39:8];
   assign write_in        =  emesh_packet_in[1];
   assign addr_remap[31:0] = {addr_in[29:18],
			      addr_in[17:16],
                             {(2){(|addr_in[17:16])}},
			     addr_in[15:0]
			     };
   assign addr_out[31:0] = (remap_en & ~remap_bypass) ? addr_remap[31:0] :
                	                                addr_in[31:0];
   always @ (posedge clk)     
     if((write_in & ~etx_wr_wait) | (~write_in & ~etx_rd_wait))
       begin
	  emesh_access_out         <= emesh_access_in;
	  emesh_packet_out[PW-1:0] <= {emesh_packet_in[PW-1:40],
				       addr_out[31:0],
				       emesh_packet_in[7:0]
				       };	
       end
endmodule