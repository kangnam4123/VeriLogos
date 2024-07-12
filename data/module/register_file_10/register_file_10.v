module register_file_10 (clk, we, dval, s1, s2, d, s1val, s2val, pc);
parameter NUM_REGISTERS = 32;
	input         clk;
	input	      we;
	input  [31:0] dval;
	input  [5:0]  s1;
	input  [5:0]  s2;
	input  [4:0]  d;
	input  [31:0] pc;
	output [31:0]  s1val;
	output [31:0]  s2val;
	reg    [31:0]  s1val = 0;
	reg    [31:0]  s2val = 0;
	reg    [31:0]  registers[0:NUM_REGISTERS-1];
	reg    [31:0]  dval_tmp = 0;
	reg    [4:0]   d_tmp = 0;
	reg            we_tmp = 0;
	wire   [31:0]  pc;
	integer 	   k;
	initial
	begin
		for (k = 0; k < NUM_REGISTERS; k = k + 1)
		begin
			if(k == 29)
			begin
				registers[k] = 32'h8002_03FF; 
			end
			else if(k == 31)
			begin
				registers[k] = 32'hDEAD_BEEF; 
			end
			else
			begin
				registers[k] = 0;
			end
		end
	end
	always @(clk or s1 or s2)
	begin
		s1val = (s1 == 0 ? 0 : s1 == 32 ? pc : registers[s1[4:0]]);
		s2val = (s2 == 0 ? 0 : s2 == 32 ? pc : registers[s2[4:0]]);
	end
	always @(negedge clk)
	begin		
		if (we == 1)
		begin
			if(d != 0)
			begin
				registers[d] = dval;
				if(s1 == d)
				begin
					s1val = (s1 == 0 ? 0 : s1 == 32 ? pc : registers[s1]);
				end
				if(s2 == d)
				begin
					s2val = (s2 == 0 ? 0 : s1 == 32 ? pc : registers[s2]);
				end
			end
		end
	end
endmodule