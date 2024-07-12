module cachefill_arbiter #(parameter WIDTH=32, parameter NUMPORTS=4)
( 
  input  clk,
  input  resetn,
  input  [NUMPORTS*WIDTH-1:0] addr,
  input  [NUMPORTS-1:0] read,
  output [NUMPORTS-1:0] waitrequest,
  output [WIDTH-1:0] fill_addr,
  output fill_read,
  input  fill_waitrequest
);
  reg  [(NUMPORTS+1)*WIDTH-1:0] queued_addr;
  reg  [(NUMPORTS+1)-1:0] queued_read;
  generate
  genvar p;
    for (p=0; p<NUMPORTS; p=p+1)
    begin : port_gen
      always@(posedge clk or negedge resetn)
        if (!resetn)
        begin
          queued_addr[p*WIDTH +: WIDTH]<=0;
          queued_read[p]<=0;
        end
        else if (fill_waitrequest && !queued_read[p])
        begin
          queued_addr[p*WIDTH +: WIDTH]<=addr[p*WIDTH +: WIDTH];
          queued_read[p]<=read[p];
        end
        else if (!fill_waitrequest)
          if (!queued_read[p+1])
          begin
            queued_addr[p*WIDTH +: WIDTH]<=addr[p*WIDTH +: WIDTH];
            queued_read[p]<=read[p];
          end
          else
          begin
            queued_addr[p*WIDTH +: WIDTH]<=queued_addr[(p+1)*WIDTH +: WIDTH];
            queued_read[p]<=queued_read[p+1];
          end
    end
  endgenerate
  always@(posedge clk) queued_read[NUMPORTS]=1'b0;
  always@(posedge clk) queued_addr[NUMPORTS*WIDTH +: WIDTH]=0;
  assign fill_addr=queued_addr[WIDTH-1:0];
  assign fill_read=queued_read[0];
  assign waitrequest=(fill_waitrequest) ? queued_read : queued_read>>1;
endmodule