module r_TX_BUF_OBJ5_BYTE_1(output reg [7:0] reg_0x65, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x65<=in_data;
			else
				reg_0x65<=reg_0x65;
		end
		else
			reg_0x65<=8'h00;
	end
endmodule