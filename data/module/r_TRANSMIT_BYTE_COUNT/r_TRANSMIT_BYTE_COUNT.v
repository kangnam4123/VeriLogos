module r_TRANSMIT_BYTE_COUNT(output reg [7:0] reg_0x51, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x51<=in_data;
			else
				reg_0x51<=reg_0x51;
		end
		else
			reg_0x51<=8'h00;
	end
endmodule