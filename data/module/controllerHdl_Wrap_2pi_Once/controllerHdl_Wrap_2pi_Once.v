module controllerHdl_Wrap_2pi_Once
          (
           x,
           wrap
          );
  input   signed [31:0] x;  
  output  signed [31:0] wrap;  
  wire signed [31:0] Two_Pi1_out1;  
  wire Relational_Operator_relop1;
  wire signed [31:0] Two_Pi3_out1;  
  wire Relational_Operator1_relop1;
  wire signed [31:0] Two_Pi2_out1;  
  wire signed [31:0] Add2_out1;  
  wire signed [31:0] Switch1_out1;  
  wire signed [31:0] Two_Pi_out1;  
  wire signed [31:0] Add1_out1;  
  wire signed [31:0] Switch_out1;  
  assign Two_Pi1_out1 = 32'sb00110010010000111111011010101001;
  assign Relational_Operator_relop1 = (x >= Two_Pi1_out1 ? 1'b1 :
              1'b0);
  assign Two_Pi3_out1 = 32'sb00000000000000000000000000000000;
  assign Relational_Operator1_relop1 = (x < Two_Pi3_out1 ? 1'b1 :
              1'b0);
  assign Two_Pi2_out1 = 32'sb00110010010000111111011010101001;
  assign Add2_out1 = x + Two_Pi2_out1;
  assign Switch1_out1 = (Relational_Operator1_relop1 == 1'b0 ? x :
              Add2_out1);
  assign Two_Pi_out1 = 32'sb00110010010000111111011010101001;
  assign Add1_out1 = x - Two_Pi_out1;
  assign Switch_out1 = (Relational_Operator_relop1 == 1'b0 ? Switch1_out1 :
              Add1_out1);
  assign wrap = Switch_out1;
endmodule