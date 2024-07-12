module r_ALERT_HIGH(output reg [7:0] reg_0x11, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x11<=in_data;
			else
				reg_0x11<=reg_0x11;
		end
		else
			reg_0x11<=8'h00;
	end
endmodule