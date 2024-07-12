module regfile_13(clk, raddr1, dout1, raddr2, dout2, wr, waddr, din, R1, R2, nrst);
	input 			clk;
	input 			wr;
	input	[4:0] 	raddr1, raddr2, waddr;
	input	[31:0] 	din;
	output	[31:0] 	dout1, dout2;
	output [7:0] R2;
	input [2:0] R1;
	input nrst;
	reg [31:0] ram [0:31];
	always @(posedge clk or negedge nrst)
	begin
		if(~nrst)
		begin
			ram[5'b00001] = {29'b0, R1};
		end
		else
		begin
			if (wr == 1'b1)
			begin
				ram[waddr] = din;
			end
		end
	end
	always @(posedge clk)
	begin
	end
	assign dout1 = (raddr1 == 5'b0) ? 32'b0 : ram[raddr1];
	assign dout2 = (raddr2 == 5'b0) ? 32'b0 : ram[raddr2];
	assign R2 = ram[4'b0010][7:0];
endmodule