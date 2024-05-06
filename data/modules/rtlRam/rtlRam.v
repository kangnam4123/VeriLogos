module rtlRam(
	clka,
	dina,
	addra,
	wea,
	douta);
parameter		dataWidth	 = 32;		
parameter		addrWidth	 = 32;		
input clka;
input [dataWidth-1 : 0] dina;
input [addrWidth-1 : 0] addra;
input wea;
output [dataWidth-1 : 0] douta;		  
reg [dataWidth-1:0] dinaReg;
reg [dataWidth-1:0] douta;   
reg [addrWidth-1:0] addraReg;
reg [dataWidth-1:0] snoopyRam [(2**addrWidth)-1:0];
reg weaReg;
always @(posedge clka)
begin				   
        addraReg <= addra;
        dinaReg  <= dina;
        douta <= snoopyRam[addraReg]; 
        weaReg <= wea;
        if(weaReg)
          snoopyRam[addraReg] <= dinaReg;
end	  
endmodule