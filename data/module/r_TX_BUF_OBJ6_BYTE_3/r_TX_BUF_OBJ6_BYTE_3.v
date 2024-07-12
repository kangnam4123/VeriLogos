module r_TX_BUF_OBJ6_BYTE_3(output reg [7:0] reg_0x6B, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x6B<=in_data;
			else
				reg_0x6B<=reg_0x6B;
		end
		else
			reg_0x6B<=8'h00;
	end
endmodule