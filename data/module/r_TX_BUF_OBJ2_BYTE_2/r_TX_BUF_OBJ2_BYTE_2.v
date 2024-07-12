module r_TX_BUF_OBJ2_BYTE_2(output reg [7:0] reg_0x5A, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x5A<=in_data;
			else
				reg_0x5A<=reg_0x5A;
		end
		else
			reg_0x5A<=8'h00;
	end
endmodule