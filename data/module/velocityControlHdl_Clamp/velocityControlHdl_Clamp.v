module velocityControlHdl_Clamp
          (
           preIntegrator,
           preSat,
           saturated,
           Clamp
          );
  input   signed [35:0] preIntegrator;  
  input   signed [35:0] preSat;  
  input   saturated;
  output  Clamp;
  wire Compare_To_Zero_out1;
  wire Compare_To_Zero1_out1;
  wire Compare_To_Zero_out1_1;
  wire Logical_Operator_out1;
  assign Compare_To_Zero_out1 = (preIntegrator <= 36'sh000000000 ? 1'b1 :
              1'b0);
  assign Compare_To_Zero1_out1 = (preSat <= 36'sh000000000 ? 1'b1 :
              1'b0);
  assign Compare_To_Zero_out1_1 =  ~ (Compare_To_Zero_out1 ^ Compare_To_Zero1_out1);
  assign Logical_Operator_out1 = Compare_To_Zero_out1_1 & saturated;
  assign Clamp = Logical_Operator_out1;
endmodule