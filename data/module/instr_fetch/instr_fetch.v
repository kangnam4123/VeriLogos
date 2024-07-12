module instr_fetch(pc,ram,instr);
	inout pc;
	input [64000:0]ram; 
	output instr;
	assign instr = ram[pc];
	assign pc = pc+4;
endmodule