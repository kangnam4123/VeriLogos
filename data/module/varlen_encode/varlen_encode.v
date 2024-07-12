module	varlen_encode (clk,
								en,	
								start, 
								d,		
								l,		
								l_late,
								q);	
  input				clk, en,start;
  input	[11:0]	d;
  output	[ 3:0]	l;
  output	[ 3:0]	l_late;
  output	[10:0]	q;
  reg		[11:0]	d1;
  reg		[10:0]	q,q0;
  reg		[ 3:0]	l,l_late;
  reg		[2:0]		cycles;
  wire			this0=  |d1[ 3:0];
  wire			this1=  |d1[ 7:4];
  wire			this2=  |d1[10:8];
  wire	[1:0]	codel0={|d1[ 3: 2],d1[ 3] || (d1[ 1] & ~d1[ 2])};
  wire	[1:0]	codel1={|d1[ 7: 6],d1[ 7] || (d1[ 5] & ~d1[ 6])};
  wire	[1:0]	codel2={|d1[   10],          (d1[ 9] & ~d1[10])};
  wire	[3:0] codel= this2? {2'b10,codel2[1:0]} :
                     (this1? {2'b01,codel1[1:0]} :
							(this0? {2'b00,codel0[1:0]} : 4'b1111));	
  always @ (negedge clk)  if (en) begin
  		cycles[2:0]	<= {cycles[1:0],start};
  end
  always @ (negedge clk) if (en && start) begin
 		d1[  11]	<=  d[11];
 		d1[10:0]	<=  d[11]?-d[10:0]:d[10:0];
  end
  always @ (negedge clk) if (en & cycles[0]) begin
		q0[10:0]	<= d1[11]?~d1[10:0]:d1[10:0];
		l	<= codel[3:0]+1;	
  end
  always @ (negedge clk) if (en & cycles[2]) begin
     q[10:0]	<= q0[10:0];
	  l_late[3:0]	<= l[3:0];
  end
endmodule