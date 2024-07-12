module iReg_2
  (
   ESCR, WPTR, ICNT, FREQ, OCNT, FCNT,
   clk, arst, idata, iaddr, iwe, FIR_WE, WFIFO_WE
   );
   parameter         r0setclr      = 15;        
   parameter         initWM        = 8'hFF;
   input             clk;          
   input             arst;         
   input [23:0]      idata;
   input [13:0]      iaddr;
   input 	     iwe;
   input 	     FIR_WE;
   input 	     WFIFO_WE;
   output [15:0]     ESCR;
   output [15:0]     WPTR;
   output [15:0]     ICNT;
   output [15:0]     FREQ;
   output [15:0]     OCNT;
   output [15:0]     FCNT;
   reg               OVFL_MSK;     
   reg               WMI_MSK;      
   reg               OVFL;         
   reg               WMI;          
   reg [15:0]        ICNT;         
   reg [7:0] 	     OCNT_WM;      
   reg [7:0] 	     OCNT_int;     
   reg 		     FIR_WE_dly1;
   reg [10:0] 	     CPTR;
   reg [15:0] 	     FCNT;
   reg [6:0] 	     FREQ_int;
   reg 		     NEWFREQ;
   reg 		     START;
   wire              setclr;
   wire 	     reg0w;
   wire 	     reg1w;
   wire 	     reg2w;
   wire 	     reg3w;
   wire 	     reg4w;
   assign setclr = reg0w & idata[r0setclr];
   assign reg0w = iaddr[2:0] == 3'h0;
   always @ (posedge clk or posedge arst)  
     if (arst !== 1'b0)
       OVFL_MSK <= 1'b0;
     else if (reg0w & idata[10])
       OVFL_MSK <= idata[r0setclr];
   always @ (posedge clk or posedge arst)  
     if (arst !== 1'b0)
       WMI_MSK <= 1'b0;
     else if (reg0w & idata[9]) 
       WMI_MSK <= idata[r0setclr];
   always @ (posedge clk or posedge arst)  
     if (arst !== 1'b0)
       OVFL <= 1'b0;     
     else if (CPTR[10] == 1'b1)    
       OVFL <= 1'b1;
     else if (reg0w & idata[2])
       OVFL <= idata[r0setclr];
   always @ (posedge clk or posedge arst)
     if (arst !== 1'b0)
       START <= 1'b0;
     else if (reg0w & idata[3])
       START <= idata[r0setclr];
   always @ (posedge clk or posedge arst)
     if  (arst !== 1'b0)
       FIR_WE_dly1 <= 1'b0;
     else
       FIR_WE_dly1 <= FIR_WE;  
   always @ (posedge clk or posedge arst)
     if (arst !== 1'b0)
       WMI <= 1'b0;
     else if (FIR_WE_dly1 & (OCNT_int[15:0] == OCNT_WM[15:0])) 
       WMI <= 1'b1;
     else if (reg0w & idata[1])
       WMI <= idata[r0setclr];
   assign ESCR[15:0]  = {setclr, 4'd0, OVFL_MSK, WMI_MSK, 5'd0, START, 
			 OVFL, WMI, 1'b0};   
   assign reg1w = iaddr[2:0] == 3'h1;
   always @ (posedge clk or posedge arst)
     if (arst !== 1'b0)
       CPTR[10:0] <= 11'd0;
     else if (OVFL == 1'b1)
       CPTR[10]   <= 1'b0;
     else
       CPTR[10:0] <= CPTR[10:0] + FIR_WE; 
   assign WPTR[15:0] = {6'd0, CPTR[9:0]};
   assign reg2w = iaddr[2:0] == 3'h2;
   always @ (posedge clk or posedge arst)
     if (arst !== 1'b0)
       ICNT[15:0] <= 16'd0;
     else if (reg2w)
       ICNT[15:0] <= idata[15:0];
     else              
       ICNT[15:0] <= ICNT[15:0] + WFIFO_WE;
   assign reg3w = iaddr[2:0] == 3'h3;
   assign setclr3 = reg3w & idata[r0setclr];
   assign setclrf = reg3w & idata[7];
   always @ (posedge clk or posedge arst)
     if (arst !== 1'b0)
       FREQ_int[6:0] <= 7'h41;  
     else if (setclrf)
       FREQ_int[6:0] <= idata[6:0];
   always @ (posedge clk or posedge arst)
     if (arst !== 1'b0)
       NEWFREQ <= 1'b0;
     else if (setclr3 & idata[14])
       NEWFREQ <= idata[r0setclr];
   assign FREQ[15:0] = {setclr3, NEWFREQ, 6'd0, setclrf, FREQ_int[6:0]};
   assign reg4w = iaddr[2:0] == 3'h4;
   always @ (posedge clk or posedge arst)
     if (arst !== 1'b0)
       OCNT_WM[7:0] <= initWM;
     else if (reg4w)
       OCNT_WM[7:0] <= idata[15:8];
   always @ (posedge clk or posedge arst)
     if (arst !== 1'b0)
       OCNT_int[7:0] <= 8'd0;
     else if (reg4w)
       OCNT_int[7:0] <= idata[7:0];
     else                              
       OCNT_int[7:0] <= OCNT_int[7:0] + FIR_WE;
   assign OCNT[15:0] = {OCNT_WM[7:0], OCNT_int[7:0]};
   assign reg5w = iaddr[2:0] == 3'h5;
   always @ (posedge clk or posedge arst)
     if (arst !== 1'b0)
       FCNT[15:0] <= 16'd0;
     else if (reg5w)
       FCNT[15:0] <= idata[15:0];
     else if (START)
       FCNT[15:0] <= FCNT[15:0] + 1;   
endmodule