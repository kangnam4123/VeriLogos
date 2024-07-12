module r_POWER_STATUS_MASK(output reg [7:0] reg_0x14, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x14<=in_data;
			else
				reg_0x14<=reg_0x14;
		end
		else
			reg_0x14<=8'h00;
	end
endmodule