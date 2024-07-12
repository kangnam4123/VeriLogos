module r_TX_BUF_OBJ1_BYTE_1(output reg [7:0] reg_0x55, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x55<=in_data;
			else
				reg_0x55<=reg_0x55;
		end
		else
			reg_0x55<=8'h00;
	end
endmodule