module r_RX_BUF_OBJ1_BYTE_2(output reg [7:0] reg_0x36, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x36<=in_data;
			else
				reg_0x36<=reg_0x36;
		end
		else
			reg_0x36<=8'h00;
	end
endmodule