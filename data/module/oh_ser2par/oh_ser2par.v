module oh_ser2par #(parameter PW = 64, 
		    parameter SW = 1,   
		    parameter CW = $clog2(PW/SW)  
		    )
   (
    input 		clk, 
    input [SW-1:0] 	din, 
    output reg [PW-1:0] dout, 
    input 		lsbfirst, 
    input 		shift      
    );
   reg [CW-1:0]    count;
   wire [PW-1:0]   shiftdata;
   always @ (posedge clk)
     if(shift & lsbfirst)
       dout[PW-1:0] <= {din[SW-1:0],dout[PW-1:SW]};
     else if(shift)
       dout[PW-1:0] <= {dout[PW-SW-1:0],din[SW-1:0]};
endmodule