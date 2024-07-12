module txclkdivide(reset, oscclk, trcal, dr, txclk);
input reset, oscclk, dr;
input [9:0] trcal; 
output txclk;
reg    txclk;
reg  [6:0]  counter;
wire [10:0] trcal2;
assign trcal2[10:1] = trcal;
assign trcal2[0] = 1'b0;
wire [11:0] trcal3;
assign trcal3 = trcal2 + trcal;
wire [11:0] dr1numerator;
assign      dr1numerator = (11'd75+trcal3); 
wire [11:0] dr0numerator;
assign      dr0numerator = (11'd4+trcal); 
wire [6:0]  tempdivider;
assign      tempdivider = dr ? ({1'b0, dr1numerator[11:7]}) : (dr0numerator[9:4]); 
wire [6:0]  divider;
assign      divider = (tempdivider >= 7'd2) ? tempdivider : 7'd2;
always @ (posedge oscclk or posedge reset) begin
  if (reset) begin
    txclk   = 0;
    counter = 0;
  end else if (counter >= (divider-1)) begin
    txclk   = 1;
    counter = 0;
  end else if (counter == ((divider-1) >> 1)) begin
    counter = counter + 7'd1;
    txclk   = 0;
  end else begin
    counter = counter + 7'd1;
  end 
end 
endmodule