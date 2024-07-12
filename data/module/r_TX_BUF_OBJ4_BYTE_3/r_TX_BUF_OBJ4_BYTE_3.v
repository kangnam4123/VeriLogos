module r_TX_BUF_OBJ4_BYTE_3(output reg [7:0] reg_0x63, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x63<=in_data;
			else
				reg_0x63<=reg_0x63;
		end
		else
			reg_0x63<=8'h00;
	end
endmodule