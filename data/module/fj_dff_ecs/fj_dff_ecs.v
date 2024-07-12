module fj_dff_ecs(q, d, clk, c, s);
output  q; 
input   d, clk, c, s;
        reg q;
	always @(posedge clk or posedge s or posedge c) begin
		if (c)
		  	q <= #1 1'b0;
		else if (s)
		  	q <= #1 1'b1;
		else
                   	q <= #1 d;
        end
endmodule