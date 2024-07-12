module tuser_design_1_axis_broadcaster_0_0 #
  (
   parameter C_S_AXIS_TUSER_WIDTH = 8,
   parameter C_M_AXIS_TUSER_WIDTH = 8
  )
  (
   input  wire [C_S_AXIS_TUSER_WIDTH-1:0] tuser,
   output wire [C_M_AXIS_TUSER_WIDTH-1:0] tuser_out
  );
  assign tuser_out = {1'b0,1'b0};
endmodule