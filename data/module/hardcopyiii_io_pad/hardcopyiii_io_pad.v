module hardcopyiii_io_pad ( 
		      padin, 
                      padout
	            );
parameter lpm_type = "hardcopyiii_io_pad";
input padin; 
output padout;
wire padin_ipd;
wire padout_opd;
buf padin_buf  (padin_ipd,padin);
assign padout_opd = padin_ipd;
buf padout_buf (padout, padout_opd);
endmodule