module ntsc_to_zbt(clk, vclk, fvh, dv, din, ntsc_addr, ntsc_data, ntsc_we, sw);
   input 	 clk;	
   input 	 vclk;	
   input [2:0] 	 fvh;
   input 	 dv;
   input [7:0] 	 din;
   output [18:0] ntsc_addr;
   output [35:0] ntsc_data;
   output 	 ntsc_we;	
   input 	 sw;		
   parameter 	 COL_START = 10'd30;
   parameter 	 ROW_START = 10'd30;
   reg [9:0] 	 col = 0;
   reg [9:0] 	 row = 0;
   reg [7:0] 	 vdata = 0;
   reg 		 vwe;
   reg 		 old_dv;
   reg 		 old_frame;	
   reg 		 even_odd;	
   wire 	 frame = fvh[2];
   wire 	 frame_edge = frame & ~old_frame;
   always @ (posedge vclk) 
     begin
	old_dv <= dv;
	vwe <= dv && !fvh[2] & ~old_dv; 
	old_frame <= frame;
	even_odd = frame_edge ? ~even_odd : even_odd;
	if (!fvh[2])
	  begin
	     col <= fvh[0] ? COL_START : 
		    (!fvh[2] && !fvh[1] && dv && (col < 1024)) ? col + 1 : col;
	     row <= fvh[1] ? ROW_START : 
		    (!fvh[2] && fvh[0] && (row < 768)) ? row + 1 : row;
	     vdata <= (dv && !fvh[2]) ? din : vdata;
	  end
     end
   reg [9:0] x[1:0],y[1:0];
   reg [7:0] data[1:0];
   reg       we[1:0];
   reg 	     eo[1:0];
   always @(posedge clk)
     begin
	{x[1],x[0]} <= {x[0],col};
	{y[1],y[0]} <= {y[0],row};
	{data[1],data[0]} <= {data[0],vdata};
	{we[1],we[0]} <= {we[0],vwe};
	{eo[1],eo[0]} <= {eo[0],even_odd};
     end
   reg old_we;
   wire we_edge = we[1] & ~old_we;
   always @(posedge clk) old_we <= we[1];
   reg [31:0] mydata;
   always @(posedge clk)
     if (we_edge)
       mydata <= { mydata[23:0], data[1] };
   reg [39:0] x_delay;
   reg [39:0] y_delay;
   reg [3:0] we_delay;
   reg [3:0] eo_delay;
   always @ (posedge clk)
   begin
     x_delay <= {x_delay[29:0], x[1]};
     y_delay <= {y_delay[29:0], y[1]};
     we_delay <= {we_delay[2:0], we[1]};
     eo_delay <= {eo_delay[2:0], eo[1]};
   end
   wire [8:0] y_addr = y_delay[38:30];
	wire [9:0] x_addr = x_delay[39:30];
   wire [18:0] myaddr = {1'b0, y_addr[8:0], eo_delay[3], x_addr[9:2]};
   wire [31:0] mydata2 = {data[1],data[1],data[1],data[1]};
   wire [18:0] myaddr2 = {1'b0, y_addr[8:0], eo_delay[3], x_addr[7:0]};
   reg [18:0] ntsc_addr;
   reg [35:0] ntsc_data;
   wire       ntsc_we = sw ? we_edge : (we_edge & (x_delay[31:30]==2'b00));
   always @(posedge clk)
     if ( ntsc_we )
       begin
	  ntsc_addr <= sw ? myaddr2 : myaddr;	
	  ntsc_data <= sw ? {4'b0,mydata2} : {4'b0,mydata};
       end
endmodule