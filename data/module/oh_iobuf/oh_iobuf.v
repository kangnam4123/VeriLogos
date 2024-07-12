module oh_iobuf #(parameter N    = 1,            
		  parameter TYPE = "BEHAVIORAL"  
		  )
   (
    inout 	   vdd, 
    inout 	   vddio,
    inout 	   vss, 
    input 	   enpullup, 
    input 	   enpulldown, 
    input 	   slewlimit, 
    input [3:0]    drivestrength, 
    input [N-1:0]  ie, 
    input [N-1:0]  oe, 
    output [N-1:0] out,
    input [N-1:0]  in, 
    inout [N-1:0]  pad
    );
   genvar 	   i;
   for (i = 0; i < N; i = i + 1) begin : gen_buf
      if(TYPE=="BEHAVIORAL") begin : gen_beh
	 assign pad[i] = oe[i] ? in[i] : 1'bZ;
	 assign out[i] = ie[i] ? pad[i] : 1'b0;
      end
      else begin : gen_custom
      end
   end
endmodule