module m2014_q4a (
	input d,
	input ena,
	output logic q
);
 
	always@(*) begin
		if (ena)
			q = d;
	end

endmodule