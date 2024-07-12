module r_TX_BUF_OBJ7_BYTE_1(output reg [7:0] reg_0x6D, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x6D<=in_data;
			else
				reg_0x6D<=reg_0x6D;
		end
		else
			reg_0x6D<=8'h00;
	end
endmodule