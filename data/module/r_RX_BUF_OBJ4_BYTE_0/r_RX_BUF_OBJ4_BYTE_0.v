module r_RX_BUF_OBJ4_BYTE_0(output reg [7:0] reg_0x40, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x40<=in_data;
			else
				reg_0x40<=reg_0x40;
		end
		else
			reg_0x40<=8'h00;
	end
endmodule