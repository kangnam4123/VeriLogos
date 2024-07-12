module fj_dff_ecs_muxscan(q, d, si, sm, clk, c, s);
output  q; 
input   d, si, sm, clk, c, s;
        reg q;
        always @(posedge clk or posedge c or posedge s) begin
		if (s)
		   	q <= #1 1'b1;	
		else if (c)
		   	q <= #1 1'b0;
                else if (sm==1'b0) 
		   	q <= #1 d;
                else if (sm==1'b1)
		   	q <= #1 si;
                else    q <= #1 1'bx;
        end
endmodule