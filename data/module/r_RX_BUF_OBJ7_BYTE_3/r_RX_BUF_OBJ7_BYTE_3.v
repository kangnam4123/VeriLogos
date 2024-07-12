module r_RX_BUF_OBJ7_BYTE_3(output reg [7:0] reg_0x4F, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x4F<=in_data;
			else
				reg_0x4F<=reg_0x4F;
		end
		else
			reg_0x4F<=8'h00;
	end
endmodule