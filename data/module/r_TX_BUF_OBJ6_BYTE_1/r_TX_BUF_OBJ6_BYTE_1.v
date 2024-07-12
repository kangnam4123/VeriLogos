module r_TX_BUF_OBJ6_BYTE_1(output reg [7:0] reg_0x69, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x69<=in_data;
			else
				reg_0x69<=reg_0x69;
		end
		else
			reg_0x69<=8'h00;
	end
endmodule