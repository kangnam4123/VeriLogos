module oh_ram  # (parameter DW      = 104,          
		  parameter DEPTH   = 32,           
		  parameter REG     = 1,            
		  parameter DUALPORT= 1,            
		  parameter AW      = $clog2(DEPTH) 
		  ) 
   (
    input 	    rd_clk,
    input 	    rd_en, 
    input [AW-1:0]  rd_addr, 
    output [DW-1:0] rd_dout, 
    input 	    wr_clk,
    input 	    wr_en, 
    input [AW-1:0]  wr_addr, 
    input [DW-1:0]  wr_wem, 
    input [DW-1:0]  wr_din, 
    input 	    bist_en, 
    input 	    bist_we, 
    input [DW-1:0]  bist_wem, 
    input [AW-1:0]  bist_addr, 
    input [DW-1:0]  bist_din, 
    input [DW-1:0]  bist_dout, 
    input 	    shutdown, 
    input 	    vss, 
    input 	    vdd, 
    input 	    vddio, 
    input [7:0]     memconfig, 
    input [7:0]     memrepair 
    );
   reg [DW-1:0]        ram    [0:DEPTH-1];  
   wire [DW-1:0]       rdata;
   wire [AW-1:0]       dp_addr;
   integer 	       i;
   assign dp_addr[AW-1:0] = (DUALPORT==1) ? rd_addr[AW-1:0] :
			                    wr_addr[AW-1:0];
   always @(posedge wr_clk)    
     for (i=0;i<DW;i=i+1)
       if (wr_en & wr_wem[i]) 
         ram[wr_addr[AW-1:0]][i] <= wr_din[i];
   assign rdata[DW-1:0] = ram[dp_addr[AW-1:0]];
   reg [DW-1:0]        rd_reg;
   always @ (posedge rd_clk)
     if(rd_en)       
       rd_reg[DW-1:0] <= rdata[DW-1:0];
   assign rd_dout[DW-1:0] = (REG==1) ? rd_reg[DW-1:0] :
		                       rdata[DW-1:0];
endmodule