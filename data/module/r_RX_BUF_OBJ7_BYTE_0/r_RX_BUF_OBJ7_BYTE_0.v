module r_RX_BUF_OBJ7_BYTE_0(output reg [7:0] reg_0x4C, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x4C<=in_data;
			else
				reg_0x4C<=reg_0x4C;
		end
		else
			reg_0x4C<=8'h00;
	end
endmodule