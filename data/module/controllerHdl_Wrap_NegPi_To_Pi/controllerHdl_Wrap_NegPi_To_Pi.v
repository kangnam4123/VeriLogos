module controllerHdl_Wrap_NegPi_To_Pi
          (
           position,
           wrap
          );
  input   signed [18:0] position;  
  output  signed [17:0] wrap;  
  wire signed [18:0] Constant1_out1;  
  wire signed [18:0] Constant_out1;  
  wire Relational_Operator1_relop1;
  wire position_less_than_pi;
  wire signed [19:0] Data_Type_Conversion_out1;  
  wire signed [18:0] Constant3_out1;  
  wire Relational_Operator_relop1;
  wire position_greater_than_pi;
  wire signed [19:0] Add1_add_cast;  
  wire signed [19:0] Add1_add_cast_1;  
  wire signed [19:0] wrap_position_less_than_neg_pi;  
  wire signed [19:0] Switch2_out1;  
  wire signed [18:0] Constant2_out1;  
  wire signed [19:0] Add_sub_cast;  
  wire signed [19:0] Add_sub_cast_1;  
  wire signed [19:0] wrap_position_greater_than_pi;  
  wire signed [19:0] Switch1_out1;  
  wire signed [17:0] Angle_Data_Type_out1;  
  assign Constant1_out1 = 19'sb0001100100100010000;
  assign Constant_out1 = 19'sb1110011011011110000;
  assign Relational_Operator1_relop1 = (position < Constant_out1 ? 1'b1 :
              1'b0);
  assign position_less_than_pi = Relational_Operator1_relop1;
  assign Data_Type_Conversion_out1 = position;
  assign Constant3_out1 = 19'sb0011001001000100000;
  assign Relational_Operator_relop1 = (position >= Constant1_out1 ? 1'b1 :
              1'b0);
  assign position_greater_than_pi = Relational_Operator_relop1;
  assign Add1_add_cast = position;
  assign Add1_add_cast_1 = Constant3_out1;
  assign wrap_position_less_than_neg_pi = Add1_add_cast + Add1_add_cast_1;
  assign Switch2_out1 = (position_less_than_pi == 1'b0 ? Data_Type_Conversion_out1 :
              wrap_position_less_than_neg_pi);
  assign Constant2_out1 = 19'sb0011001001000100000;
  assign Add_sub_cast = position;
  assign Add_sub_cast_1 = Constant2_out1;
  assign wrap_position_greater_than_pi = Add_sub_cast - Add_sub_cast_1;
  assign Switch1_out1 = (position_greater_than_pi == 1'b0 ? Switch2_out1 :
              wrap_position_greater_than_pi);
  assign Angle_Data_Type_out1 = {Switch1_out1[16:0], 1'b0};
  assign wrap = Angle_Data_Type_out1;
endmodule