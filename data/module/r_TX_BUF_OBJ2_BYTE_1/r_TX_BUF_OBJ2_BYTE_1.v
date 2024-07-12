module r_TX_BUF_OBJ2_BYTE_1(output reg [7:0] reg_0x59, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x59<=in_data;
			else
				reg_0x59<=reg_0x59;
		end
		else
			reg_0x59<=8'h00;
	end
endmodule