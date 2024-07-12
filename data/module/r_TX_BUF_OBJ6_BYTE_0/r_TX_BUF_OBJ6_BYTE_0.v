module r_TX_BUF_OBJ6_BYTE_0(output reg [7:0] reg_0x68, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x68<=in_data;
			else
				reg_0x68<=reg_0x68;
		end
		else
			reg_0x68<=8'h00;
	end
endmodule