module multicyclestall(request, devwait,clk,resetn,stalled);
input request;
input devwait;
input clk;
input resetn;
output stalled;
  reg T;
  always@(posedge clk)
    if (~resetn)
      T<=0;
    else
      T<=stalled;
  assign stalled=(T) ? devwait : request;
endmodule