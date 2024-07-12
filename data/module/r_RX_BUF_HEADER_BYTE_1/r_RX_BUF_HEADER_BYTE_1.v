module r_RX_BUF_HEADER_BYTE_1(output reg [7:0] reg_0x33, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x33<=in_data;
			else
				reg_0x33<=reg_0x33;
		end
		else
			reg_0x33<=8'h00;
	end
endmodule