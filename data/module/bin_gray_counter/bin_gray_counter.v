module bin_gray_counter #
  (
   parameter N = 0,     
   parameter INIT = 0   
   )
   (
    input              clk,
    input              rst,
    input              inc,
    output reg [N-1:0] binary,
    output reg [N-1:0] gray
    );
   wire [N-1:0]        next_binary = binary + 1'b1;
   wire [N-1:0]        next_gray = next_binary ^ (next_binary >> 1);
   always @(posedge clk or posedge rst) begin
      if (rst) begin
         binary <= INIT;
         gray <= INIT ^ (INIT >> 1);
      end else if (inc) begin
         binary <= next_binary;
         gray <= next_gray;
      end
   end
endmodule