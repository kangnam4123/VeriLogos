module r_TX_BUF_OBJ2_BYTE_0(output reg [7:0] reg_0x58, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x58<=in_data;
			else
				reg_0x58<=reg_0x58;
		end
		else
			reg_0x58<=8'h00;
	end
endmodule