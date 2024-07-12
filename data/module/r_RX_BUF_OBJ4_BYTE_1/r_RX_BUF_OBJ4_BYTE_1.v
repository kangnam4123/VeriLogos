module r_RX_BUF_OBJ4_BYTE_1(output reg [7:0] reg_0x41, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x41<=in_data;
			else
				reg_0x41<=reg_0x41;
		end
		else
			reg_0x41<=8'h00;
	end
endmodule