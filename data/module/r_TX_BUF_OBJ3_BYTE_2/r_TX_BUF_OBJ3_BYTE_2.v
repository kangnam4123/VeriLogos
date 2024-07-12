module r_TX_BUF_OBJ3_BYTE_2(output reg [7:0] reg_0x5E, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x5E<=in_data;
			else
				reg_0x5E<=reg_0x5E;
		end
		else
			reg_0x5E<=8'h00;
	end
endmodule