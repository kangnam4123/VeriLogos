module bsg_dff_en_width_p36
(
  clock,
  data_i,
  en_i,
  data_o
);
  input [35:0] data_i;
  output [35:0] data_o;
  input clock;
  input en_i;
  reg [35:0] data_o;
  always @(posedge clock) begin
    if(en_i) begin
      { data_o[35:0] } <= { data_i[35:0] };
    end
  end
endmodule