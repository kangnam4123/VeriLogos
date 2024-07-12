module r_RX_BUF_OBJ6_BYTE_1(output reg [7:0] reg_0x49, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x49<=in_data;
			else
				reg_0x49<=reg_0x49;
		end
		else
			reg_0x49<=8'h00;
	end
endmodule