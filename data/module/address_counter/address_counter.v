module address_counter #
(
  parameter integer COUNT_WIDTH = 13
)
(
  input  wire clken, 
  input  wire trig, 
  input  wire clk,
  output wire [31:0] address,
  output wire [3:0] wen 
);
  localparam count_max = (1 << COUNT_WIDTH) - 1;
  reg trig_reg;
  reg trig_detected;
  reg wen_reg;
  reg [COUNT_WIDTH-1:0] count;
  initial count = 0;
  initial trig_detected = 0;
  initial wen_reg = 0;
  always @(posedge clk) begin
    trig_reg <= trig;
    if (trig & ~trig_reg) begin
        trig_detected <= 1;
    end else if (count == count_max) begin
        trig_detected <= 0;
    end
  end
  always @(posedge clk) begin
    if (clken) begin
      count <= count + 1;
      if (count == count_max) begin
        wen_reg <= trig_detected;
      end
    end
  end
  assign address = count << 2;
  assign wen = {4{wen_reg}};
endmodule