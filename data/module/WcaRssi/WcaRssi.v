module WcaRssi (
    input clock, 
    input reset, 
    input strobe,
	input [11:0] adc, 
    output [7:0] rssi 
    );
   wire [11:0] abs_adc = adc[11] ? ~adc : adc;
   reg [23:0]  rssi_int;
   always @(posedge clock)
     if(reset )
       rssi_int <= #1 24'd0;
     else if (strobe)
       rssi_int <= #1 rssi_int + abs_adc - {1'b0,rssi_int[23:13]};
   assign      rssi = rssi_int[23:16];
endmodule