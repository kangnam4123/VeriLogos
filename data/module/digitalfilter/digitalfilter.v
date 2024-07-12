module digitalfilter(output out, input clk, input ce, input in);
  reg [5:0] taps = 6'b000000;
  reg result = 0;
  assign out = result;
  always @(posedge clk)
  begin
    if(ce)
      begin
        taps[5] <= taps[4];
        taps[4] <= taps[3];
    	taps[3] <= taps[2];
    	taps[2] <= taps[1];
    	taps[1] <= taps[0];
        taps[0] <= in;
      end
    if(taps[2] & taps[3] & taps[4] & taps[5])
      result <= 1;
    if(~taps[2] & ~taps[3] & ~taps[4] & ~taps[5])
      result <= 0;
  end
endmodule