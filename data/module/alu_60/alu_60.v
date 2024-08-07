module alu_60(
   			A,
			B,
			ALU_operation,
			shamt,
			res,
			zero,
			overflow
    );
	input wire	[31: 0] A, B;
	input wire 	[ 3: 0] ALU_operation;
	input wire  [ 4: 0] shamt;
	output reg  [31: 0] res;
	output wire 		zero;
	output wire 		overflow;
  	wire 		[31: 0]	res_and, res_or, res_add, res_sub, res_nor, res_slt,
             			res_xor, res_srl, res_sll, res_addu, res_subu, res_sltu, res_lh, res_sh, res_sra, res_lhu;
	reg 		[31: 0] mask4 = 32'h0000_ffff;
  	wire 		[31: 0] mask;
	wire     	[31: 0] res_tmp;
  	assign mask =  B[1] ? 32'hffff_0000 : 32'h0000_ffff;
	assign res_tmp = A & mask;
  	always @(posedge ALU_operation[0]) mask4 = mask;
  	parameter one 	= 32'h00000001, zero_0 	= 32'h00000000;
  	assign res_and 	= A & B;
  	assign res_or 	= A | B;
  	assign res_nor 	= ~(A | B);
  	assign res_xor 	= A ^ B;
  	assign res_srl 	= B >> shamt;
  	assign res_sll 	= B << shamt;
	assign res_sra  = $signed(B) >>> shamt; 
  	assign res_add 	= $signed(A) + $signed(B);
  	assign res_sub 	= $signed(A) - $signed(B);
  	assign res_slt 	= ($signed(A) < $signed(B)) ? one : zero_0;
  	assign res_addu =  $unsigned(A) + $unsigned(B);
  	assign res_subu =  $unsigned(A) - $unsigned(B);
  	assign res_sltu = ($unsigned(A) < $unsigned(B)) ? one : zero_0;
  	assign res_lh 	= B[1] ? {{16{res_tmp[31]}}, res_tmp[31:16]} : {{16{res_tmp[15]}}, res_tmp[15:0]};
	assign res_lhu	= B[1] ? {16'h0, res_tmp[31:16]} : {16'h0, res_tmp[15:0]};
  	assign res_sh 	= mask4[0] ? (A&(~mask4) | {16'h0, B[15:0]}) : (A&(~mask4) | {B[15:0], 16'h0});
  	always @(*)
     	case (ALU_operation)
	     	4'b0000: res = res_and;
		  	4'b0001: res = res_or;
		  	4'b0010: res = res_add;
		  	4'b0110: res = res_sub;
		  	4'b0100: res = res_nor;
		  	4'b0111: res = res_slt;
		  	4'b0011: res = res_xor;
		  	4'b0101: res = res_srl;
		  	4'b1000: res = res_sll;
		  	4'b1001: res = res_addu;
		  	4'b1010: res = res_subu;
		  	4'b1011: res = res_sltu;
		  	4'b1100: res = res_lh;
		  	4'b1101: res = res_sh;
			4'b1110: res = res_sra;
			4'b1111: res = res_lhu;
		  	default: res = res_add;
		endcase
  	assign zero = (res == zero_0) ? 1'b1 : 1'b0;
endmodule