module jbi_shift_64
(ck, ser_in, d_in, shift_l, load_l, d_out);
input	ck;		
input	ser_in;		
input	[63:0] d_in;	
input	shift_l;	
input	load_l;		
output	[63:0] d_out;	
reg [63:0] d, next_d;
    always @(shift_l or load_l or ser_in or d_in or d)
    begin
   	if (load_l == 1'b0) next_d = d_in;
	else if (load_l == 1'b1)
	begin
	    if (shift_l == 1'b1) next_d = d;
	    else if (shift_l == 1'b0) 
	    begin
		next_d = {d[62:0],ser_in};
	    end
	    else next_d = {64{1'bx}};
	end
        else next_d = {64{1'bx}};
    end
    always @(posedge ck) d <= next_d ;
    assign d_out = d;
endmodule