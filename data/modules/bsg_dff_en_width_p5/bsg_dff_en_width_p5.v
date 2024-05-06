module bsg_dff_en_width_p5
(
  clock,
  data_i,
  en_i,
  data_o
);
  input [4:0] data_i;
  output [4:0] data_o;
  input clock;
  input en_i;
  reg [4:0] data_o;
  always @(posedge clock) begin
    if(en_i) begin
      { data_o[4:0] } <= { data_i[4:0] };
    end
  end
endmodule