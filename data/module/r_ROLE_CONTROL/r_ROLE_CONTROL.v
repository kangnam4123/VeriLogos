module r_ROLE_CONTROL(output reg [7:0] reg_0x1A, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x1A<=in_data;
			else
				reg_0x1A<=reg_0x1A;
		end
		else
			reg_0x1A<=8'h00;
	end
endmodule