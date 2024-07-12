module  maxii_crcblock (
    clk,
    shiftnld,
    crcerror,
    regout);
input clk;
input shiftnld;
output crcerror;
output regout;
assign crcerror = 1'b0;
assign regout = 1'b0;
parameter oscillator_divider = 1;
parameter lpm_type = "maxii_crcblock";
endmodule