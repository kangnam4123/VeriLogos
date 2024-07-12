module ds8dac1(clk, in_data, sout);
input clk;
input [7:0] in_data;
output reg sout;
reg [8:0] PWM_accumulator;
reg [7:0] PWM_add;
initial
begin
	PWM_accumulator <= 0;
	PWM_add <=0;
end
always @(posedge clk) begin
	PWM_accumulator <= PWM_accumulator[7:0] + PWM_add;
	PWM_add <= in_data;
end
always @(negedge clk) begin
	sout <= PWM_accumulator[8];
end
endmodule