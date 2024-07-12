module r_RX_BUF_OBJ7_BYTE_2(output reg [7:0] reg_0x4E, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x4E<=in_data;
			else
				reg_0x4E<=reg_0x4E;
		end
		else
			reg_0x4E<=8'h00;
	end
endmodule