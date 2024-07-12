module  fifo_2k_dffpipe_dm2
	( 
	clock,
	clrn,
	d,
	q) 
		;
	input   clock;
	input   clrn;
	input   [10:0]  d;
	output   [10:0]  q;
	wire	[10:0]	wire_dffe6a_D;
	reg	[10:0]	dffe6a;
	wire ena;
	wire prn;
	wire sclr;
	initial
		dffe6a[0:0] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[0:0] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[0:0] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[0:0] <= wire_dffe6a_D[0:0];
	initial
		dffe6a[1:1] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[1:1] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[1:1] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[1:1] <= wire_dffe6a_D[1:1];
	initial
		dffe6a[2:2] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[2:2] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[2:2] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[2:2] <= wire_dffe6a_D[2:2];
	initial
		dffe6a[3:3] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[3:3] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[3:3] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[3:3] <= wire_dffe6a_D[3:3];
	initial
		dffe6a[4:4] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[4:4] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[4:4] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[4:4] <= wire_dffe6a_D[4:4];
	initial
		dffe6a[5:5] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[5:5] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[5:5] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[5:5] <= wire_dffe6a_D[5:5];
	initial
		dffe6a[6:6] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[6:6] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[6:6] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[6:6] <= wire_dffe6a_D[6:6];
	initial
		dffe6a[7:7] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[7:7] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[7:7] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[7:7] <= wire_dffe6a_D[7:7];
	initial
		dffe6a[8:8] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[8:8] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[8:8] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[8:8] <= wire_dffe6a_D[8:8];
	initial
		dffe6a[9:9] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[9:9] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[9:9] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[9:9] <= wire_dffe6a_D[9:9];
	initial
		dffe6a[10:10] = 0;
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a[10:10] <= 1'b1;
		else if (clrn == 1'b0) dffe6a[10:10] <= 1'b0;
		else if  (ena == 1'b1)   dffe6a[10:10] <= wire_dffe6a_D[10:10];
	assign
		wire_dffe6a_D = (d & {11{(~ sclr)}});
	assign
		ena = 1'b1,
		prn = 1'b1,
		q = dffe6a,
		sclr = 1'b0;
endmodule