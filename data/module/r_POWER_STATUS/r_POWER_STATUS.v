module r_POWER_STATUS(output reg [7:0] reg_0x1E, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x1E<=in_data;
			else
				reg_0x1E<=reg_0x1E;
		end
		else
			reg_0x1E<=8'h00;
	end
endmodule