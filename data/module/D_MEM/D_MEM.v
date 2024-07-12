module D_MEM(input clk, MemWrite, MemRead, input [31:0] Address, Write_data, 
	output reg [31:0] Read_data);
	reg [31:0] MEM [128:0];
	initial
		begin
			MEM[0] <= 32'b0000_0000_0000_0000_0000_0000_0000_0000; 
			MEM[1] <= 32'b0000_0000_0000_0000_0000_0000_0000_0001; 
			MEM[2] <= 32'b0000_0000_0000_0000_0000_0000_0000_0010; 
			MEM[3] <= 32'b0000_0000_0000_0000_0000_0000_0000_0011; 
			MEM[4] <= 32'b0000_0000_0000_0000_0000_0000_0000_0100; 
			MEM[5] <= 32'b0000_0000_0000_0000_0000_0000_0000_0101; 
		end
	always @ *
		begin
			Read_data <= MEM[Address];
		end
	always @ (posedge clk && MemWrite)
		begin
			MEM[Address] <= Write_data;
		end
endmodule