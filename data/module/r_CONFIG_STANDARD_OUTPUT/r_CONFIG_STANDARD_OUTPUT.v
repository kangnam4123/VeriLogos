module r_CONFIG_STANDARD_OUTPUT(output reg [7:0] reg_0x18, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x18<=in_data;
			else
				reg_0x18<=reg_0x18;
		end
		else
			reg_0x18<=8'h00;
	end
endmodule