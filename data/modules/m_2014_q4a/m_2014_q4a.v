module m_2014_q4a (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
 
	always @(posedge clk) begin 
        if(L) Q <= R;
        else begin
            if(E) Q <= w;
            else Q <= Q;
        end
    end
	
endmodule
