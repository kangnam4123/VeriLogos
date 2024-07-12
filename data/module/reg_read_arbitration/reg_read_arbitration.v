module reg_read_arbitration (
	input wire [3:0] get_opnd1,
	input wire is_opnd1, 
	input wire [3:0] get_opnd2,
	input wire is_opnd2, 
	input wire [31:0] r00_Q,
	input wire [31:0] r01_Q,
	input wire [31:0] r02_Q,
	input wire [31:0] r03_Q,
	input wire [31:0] r04_Q,
	input wire [31:0] r05_Q,
	input wire [31:0] r06_Q,
	input wire [31:0] r07_Q,
	input wire [31:0] r08_Q,
	input wire [31:0] r09_Q,
	input wire [31:0] r10_Q,
	input wire [31:0] r11_Q,
	input wire [31:0] r12_Q,
	input wire [31:0] r13_Q,
	input wire [31:0] r14_Q,
	input wire [31:0] r15_Q,
 	input wire [15:0] hold_Q,
 	output wire [31:0] value_opnd1,
 	output wire [31:0] value_opnd2, 
	output wire [1:0] flags
 );
	wire opnd1_held = (get_opnd1 == 4'h0) ? hold_Q[0] : (
		(get_opnd1 == 4'h1) ? hold_Q[01] :
		(get_opnd1 == 4'h2) ? hold_Q[02] :
		(get_opnd1 == 4'h3) ? hold_Q[03] :
		(get_opnd1 == 4'h4) ? hold_Q[04] :
		(get_opnd1 == 4'h5) ? hold_Q[05] :
		(get_opnd1 == 4'h6) ? hold_Q[06] :
		(get_opnd1 == 4'h7) ? hold_Q[07] :
		(get_opnd1 == 4'h8) ? hold_Q[08] :
		(get_opnd1 == 4'h9) ? hold_Q[09] :
		(get_opnd1 == 4'hA) ? hold_Q[10] :
		(get_opnd1 == 4'hB) ? hold_Q[11] :
		(get_opnd1 == 4'hC) ? hold_Q[12] :
		(get_opnd1 == 4'hD) ? hold_Q[13] :
		(get_opnd1 == 4'hE) ? hold_Q[14] : hold_Q[15] );
	wire opnd2_held = (get_opnd2 == 4'h0) ? hold_Q[0] : (
		(get_opnd2 == 4'h1) ? hold_Q[01] :
		(get_opnd2 == 4'h2) ? hold_Q[02] :
		(get_opnd2 == 4'h3) ? hold_Q[03] :
		(get_opnd2 == 4'h4) ? hold_Q[04] :
		(get_opnd2 == 4'h5) ? hold_Q[05] :
		(get_opnd2 == 4'h6) ? hold_Q[06] :
		(get_opnd2 == 4'h7) ? hold_Q[07] :
		(get_opnd2 == 4'h8) ? hold_Q[08] :
		(get_opnd2 == 4'h9) ? hold_Q[09] :
		(get_opnd2 == 4'hA) ? hold_Q[10] :
		(get_opnd2 == 4'hB) ? hold_Q[11] :
		(get_opnd2 == 4'hC) ? hold_Q[12] :
		(get_opnd2 == 4'hD) ? hold_Q[13] :
		(get_opnd2 == 4'hE) ? hold_Q[14] : hold_Q[15] );
	assign flags = {opnd1_held&is_opnd1, opnd2_held&is_opnd2 };
	assign value_opnd1 = (is_opnd1 == 1'b0) ? 32'bZ : (
		(get_opnd1 == 4'h0) ? r00_Q :
		(get_opnd1 == 4'h1) ? r01_Q :			
		(get_opnd1 == 4'h2) ? r02_Q :
		(get_opnd1 == 4'h3) ? r03_Q :
		(get_opnd1 == 4'h4) ? r04_Q :
		(get_opnd1 == 4'h5) ? r05_Q :
		(get_opnd1 == 4'h6) ? r06_Q :
		(get_opnd1 == 4'h7) ? r07_Q :
		(get_opnd1 == 4'h8) ? r08_Q :
		(get_opnd1 == 4'h9) ? r09_Q :
		(get_opnd1 == 4'hA) ? r10_Q :
		(get_opnd1 == 4'hB) ? r11_Q :
		(get_opnd1 == 4'hC) ? r12_Q :
		(get_opnd1 == 4'hD) ? r13_Q :
		(get_opnd1 == 4'hE) ? r14_Q : r15_Q );
	assign value_opnd2 = (is_opnd2 == 1'b0) ? 32'bZ : (
		(get_opnd2 == 4'h0) ? r00_Q :			
		(get_opnd2 == 4'h1) ? r01_Q :
		(get_opnd2 == 4'h2) ? r02_Q :
		(get_opnd2 == 4'h3) ? r03_Q :
		(get_opnd2 == 4'h4) ? r04_Q :
		(get_opnd2 == 4'h5) ? r05_Q :
		(get_opnd2 == 4'h6) ? r06_Q :
		(get_opnd2 == 4'h7) ? r07_Q :
		(get_opnd2 == 4'h8) ? r08_Q :
		(get_opnd2 == 4'h9) ? r09_Q :
		(get_opnd2 == 4'hA) ? r10_Q :
		(get_opnd2 == 4'hB) ? r11_Q :
		(get_opnd2 == 4'hC) ? r12_Q :
		(get_opnd2 == 4'hD) ? r13_Q :
		(get_opnd2 == 4'hE) ? r14_Q : r15_Q );
endmodule