module r_TX_BUF_HEADER_BYTE_1(output reg [7:0] reg_0x53, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x53<=in_data;
			else
				reg_0x53<=reg_0x53;
		end
		else
			reg_0x53<=8'h00;
	end
endmodule