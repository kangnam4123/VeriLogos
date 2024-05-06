module bsg_dff_width_p1890
(
  clock,
  data_i,
  data_o
);
  input [1889:0] data_i;
  output [1889:0] data_o;
  input clock;
  reg [1889:0] data_o;
  always @(posedge clock) begin
    if(1'b1) begin
      { data_o[1889:0] } <= { data_i[1889:0] };
    end
  end
endmodule