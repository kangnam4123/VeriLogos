module bw_io_ddr_mclk_txrx(
   out, 
   pad, 
   vrefcode, vdd_h, cbu, cbd, data, oe, odt_enable
   );
input [7:0]     vrefcode;       
input           odt_enable;    	
input           vdd_h;         	
input [8:1]     cbu;            
input [8:1]     cbd;            
input           data;        	
input           oe;          	
inout           pad;            
output          out;            
assign pad = oe ? data : 1'bz;
assign out = pad;
endmodule