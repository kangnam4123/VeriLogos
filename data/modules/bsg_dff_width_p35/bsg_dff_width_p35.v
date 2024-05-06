module bsg_dff_width_p35
(
  clock,
  data_i,
  data_o
);
  input [34:0] data_i;
  output [34:0] data_o;
  input clock;
  reg [34:0] data_o;
  always @(posedge clock) begin
    if(1'b1) begin
      { data_o[34:0] } <= { data_i[34:0] };
    end
  end
endmodule