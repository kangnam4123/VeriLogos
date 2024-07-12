module r_ALERT_MASK_LOW(output reg [7:0] reg_0x12, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x12<=in_data;
			else
				reg_0x12<=reg_0x12;
		end
		else
			reg_0x12<=8'h00;
	end
endmodule