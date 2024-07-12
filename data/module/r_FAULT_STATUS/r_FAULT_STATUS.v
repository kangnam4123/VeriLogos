module r_FAULT_STATUS(output reg [7:0] reg_0x1F, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x1F<=in_data;
			else
				reg_0x1F<=reg_0x1F;
		end
		else
			reg_0x1F<=8'h00;
	end
endmodule