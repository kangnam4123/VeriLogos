module oh_iddr_1 #(parameter DW      = 1 
		 )
   (
    input 		clk, 
    input 		ce0, 
    input 		ce1, 
    input [DW/2-1:0] 	din, 
    output reg [DW-1:0] dout 
    );
   reg [DW/2-1:0]     din_sl;
   reg [DW/2-1:0]     din_sh;
   reg 		      ce0_negedge;
   always @ (negedge clk)
     ce0_negedge <= ce0;
   always @ (posedge clk)
     if(ce0)
       din_sl[DW/2-1:0] <= din[DW/2-1:0];
   always @ (negedge clk)
     if(ce0_negedge)
       din_sh[DW/2-1:0] <= din[DW/2-1:0];
   always @ (posedge clk)
     if(ce1)
       dout[DW-1:0] <= {din_sh[DW/2-1:0],
			din_sl[DW/2-1:0]};
endmodule