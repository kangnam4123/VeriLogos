module div100k(input wire clk, output reg pulse);
   reg [17:0] counter;
   always@(posedge clk) begin
      pulse <= counter[17];
      if (counter[17])
        counter <= counter - 999999;
      else
        counter <= counter + 1;
   end
endmodule