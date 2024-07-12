module rw_manager_lfsr72(
	clk, 
	nrst, 
	ena, 
	word
);
	input clk;
	input nrst;
	input ena;
	output reg [71:0] word;
	always @(posedge clk or negedge nrst) begin
		if(~nrst) begin
			word <= 72'hAAF0F0AA55F0F0AA55;
		end
		else if(ena) begin
			word[71] <= word[0];
			word[70:66] <= word[71:67];
			word[65] <= word[66] ^ word[0];
			word[64:25] <= word[65:26];
			word[24] <= word[25] ^ word[0];
			word[23:19] <= word[24:20];
			word[18] <= word[19] ^ word[0];
			word[17:0] <= word[18:1];
		end
	end
endmodule