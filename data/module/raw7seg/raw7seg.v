module raw7seg(clk, segment, anode, word);
   parameter SEG_UNITS = 4;
   parameter INVERT_ANODES = 1;
   parameter INVERT_SEGMENTS = 1;
   input clk;
   output [(SEG_UNITS - 1):0] anode;
   output [7:0] segment;
   input [(SEG_UNITS * 8 - 1):0] word;
   reg [15:0] 	cnt;
   always @(posedge clk) cnt<=cnt+16'h1;
   wire 	cntovf = &cnt;
   reg [3:0] 	an_index;
   reg [7:0] 	SevenSeg;
   reg [(SEG_UNITS * 8 - 1):0] word_shifted;
   generate
      if (INVERT_SEGMENTS)
	begin: if_is
	   assign segment = ~word_shifted[7:0];
	end
      else
	begin: else_is
	   assign segment = word_shifted[7:0];
	end
   endgenerate
   always @(posedge cntovf)
     if (an_index == SEG_UNITS - 1)
       an_index <= 0;
     else
       an_index <= an_index + 1;
   always @(posedge clk)
     word_shifted <= word >> (an_index * 8);
   localparam [(SEG_UNITS - 1):0] 	anode_init = 1;
   generate
      if (INVERT_ANODES)
	begin: if_ia
	   assign anode = ~(anode_init << an_index);
	end
      else
	begin: else_ia
	   assign anode = (anode_init << an_index);
	end
   endgenerate
endmodule