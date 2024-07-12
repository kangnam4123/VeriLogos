module instr_mem (	input [31:0] address,
					output [31:0] instruction );
 	reg [31:0] memory [249:0];
 	integer i;
	initial
		begin
			for (i=0; i<250; i=i+1)
              memory[i] = 32'b0;
          memory[10] = 32'b001000_00000_01000_00000_00000_000101;    
          memory[11] = 32'b101011_00100_00101_00000_00000_000000;    
          memory[12] = 32'b100011_00100_00110_00000_00000_000000; 	
		end
	assign instruction = memory[address >> 2];
endmodule