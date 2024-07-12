module r_RX_BUF_OBJ1_BYTE_3(output reg [7:0] reg_0x37, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x37<=in_data;
			else
				reg_0x37<=reg_0x37;
		end
		else
			reg_0x37<=8'h00;
	end
endmodule