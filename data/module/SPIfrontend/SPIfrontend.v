module SPIfrontend(nCS, CLK, MOSI, MISO, 
		   inbyte, outbyte, out_valid);
   input nCS;
   input CLK;
   input MOSI;
   output MISO;
   reg 	  MISO;
   input [7:0] inbyte;
   output [7:0] outbyte;
   reg [7:0] 	outbyte;
   output 	out_valid;
   reg [2:0] 	bitcnt;
   assign 	out_valid = bitcnt==0;
   always @(posedge nCS) begin 
      bitcnt<=0;
      outbyte<=0;
   end
   always @(posedge CLK) if (!nCS) begin
      MISO<=inbyte[bitcnt];
   end 
   always @(negedge CLK) if (!nCS) begin
      if (bitcnt)
	outbyte[bitcnt]<=MOSI;
      else
	outbyte<=MOSI;
      bitcnt<=bitcnt+1;
   end
endmodule