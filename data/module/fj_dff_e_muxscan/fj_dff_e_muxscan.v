module fj_dff_e_muxscan(q, d, si, sm, clk);
output q;
input d, si, sm, clk;
        reg q;
        always @(posedge clk) begin
                if (sm==1'b0) 
		  	q <= #1 d;
                else if (sm==1'b1)
		  	q <= #1 si;
                else    q <= #1 1'bx;
        end
endmodule