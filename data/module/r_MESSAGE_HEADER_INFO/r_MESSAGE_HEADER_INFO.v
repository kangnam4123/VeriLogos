module r_MESSAGE_HEADER_INFO(output reg [7:0] reg_0x2E, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x2E<=in_data;
			else
				reg_0x2E<=reg_0x2E;
		end
		else
			reg_0x2E<=8'h00;
	end
endmodule