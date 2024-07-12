module MIPS_Register(Rs_addr,Rt_addr,Rd_addr,Clk,Rd_write_byte_en,Rd_in,Rs_out,Rt_out);
input Clk;
input [4:0]Rs_addr,Rt_addr,Rd_addr;
input [31:0]Rd_in;
input [3:0]Rd_write_byte_en;
output [31:0]Rs_out,Rt_out; 
reg [31:0]register[31:0];
assign Rs_out = register[Rs_addr];
assign Rt_out = register[Rt_addr];
initial
begin
	register[0] = 32'h0;
	register[1] = 32'h11112345;
	register[2] = 32'h2;
	register[3] = 32'h3;
	register[4] = 32'h4;
	register[5] = 32'h55556789;
	register[8] = 32'h88;
	register[9] = 32'h5467_8932;
	register[10] = 32'h3476_8906;
	register[11] = 32'hfffa_bcde;
	register[12] = 32'h6789_3954;
	register[30] = 32'hffff_ffff;
	register[31] = 32'h7fff_ffff;
end
always @(negedge Clk)
begin
	 if(Rd_addr!=0)
	 begin
	 case(Rd_write_byte_en)
	 4'b0001: register[Rd_addr][7:0] <= Rd_in[7:0];
	 4'b0010: register[Rd_addr][15:8] <= Rd_in[15:8];
	 4'b0011: register[Rd_addr][15:0] <= Rd_in[15:0];
	 4'b0100: register[Rd_addr][23:16] <= Rd_in[23:16];
	 4'b0101: begin register[Rd_addr][23:16] <= Rd_in[23:16]; register[Rd_addr][7:0] <= Rd_in[7:0];end
	 4'b0110: register[Rd_addr][23:8] <= Rd_in[23:8];
	 4'b0111: register[Rd_addr][23:0] <= Rd_in[23:0];
	 4'b1000: register[Rd_addr][31:24] <= Rd_in[31:24];
	 4'b1001: begin register[Rd_addr][31:24] <= Rd_in[31:24]; register[Rd_addr][7:0] <= Rd_in[7:0];end
	 4'b1010: begin register[Rd_addr][31:24] <= Rd_in[31:24]; register[Rd_addr][15:8] <= Rd_in[15:8];end
	 4'b1011: begin register[Rd_addr][31:24] <= Rd_in[31:24]; register[Rd_addr][15:0] <= Rd_in[15:0];end
	 4'b1100: register[Rd_addr][31:16] <= Rd_in[31:16];
	 4'b1101: begin register[Rd_addr][31:16] <= Rd_in[31:16]; register[Rd_addr][7:0] <= Rd_in[7:0];end
	 4'b1110: register[Rd_addr][31:8] <= Rd_in[31:8];
	 4'b1111: register[Rd_addr] <= Rd_in; 
	 default:;
	 endcase
	 end 
end 
endmodule