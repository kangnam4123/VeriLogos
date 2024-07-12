module MUX_4 #(parameter SIZE=32)
(
	input wire Select,
	input wire [SIZE-1:0]Data_B,
	input wire [SIZE-1:0]Data_A,
	output reg [SIZE-1:0] Out
);
always @(*)
	begin
		if(Select==1)
			Out<=Data_A;
		else if (Select==0)
			Out<=Data_B;
	end
endmodule