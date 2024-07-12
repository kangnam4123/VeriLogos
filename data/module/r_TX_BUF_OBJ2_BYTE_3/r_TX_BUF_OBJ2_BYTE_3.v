module r_TX_BUF_OBJ2_BYTE_3(output reg [7:0] reg_0x5B, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x5B<=in_data;
			else
				reg_0x5B<=reg_0x5B;
		end
		else
			reg_0x5B<=8'h00;
	end
endmodule