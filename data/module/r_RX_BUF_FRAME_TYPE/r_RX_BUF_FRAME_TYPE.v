module r_RX_BUF_FRAME_TYPE(output reg [7:0] reg_0x31, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x31<=in_data;
			else
				reg_0x31<=reg_0x31;
		end
		else
			reg_0x31<=8'h00;
	end
endmodule