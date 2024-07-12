module uart_42 (reset, txclk, ld_tx_data, tx_empty, tx_cnt);
input reset;
input txclk;
input ld_tx_data;
output reg tx_empty;
output reg [3:0] tx_cnt;
always @ (posedge txclk)
if (reset) begin
  tx_empty      <= 1;
  tx_cnt        <= 0;
end else begin
   if (ld_tx_data) begin
     tx_empty <= 0;
   end
   if (!tx_empty) begin
     tx_cnt <= tx_cnt + 1;
   end
end
endmodule