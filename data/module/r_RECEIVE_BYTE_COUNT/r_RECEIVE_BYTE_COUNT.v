module r_RECEIVE_BYTE_COUNT(output reg [7:0] reg_0x30, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x30<=in_data;
			else
				reg_0x30<=reg_0x30;
		end
		else
			reg_0x30<=8'h00;
	end
endmodule