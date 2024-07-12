module controllerHdl_Complex_Multiply
          (
           In1_re,
           In1_im,
           In2_re,
           In2_im,
           Re,
           Im
          );
  input   signed [17:0] In1_re;  
  input   signed [17:0] In1_im;  
  input   signed [17:0] In2_re;  
  input   signed [17:0] In2_im;  
  output  signed [35:0] Re;  
  output  signed [35:0] Im;  
  wire signed [35:0] Product_out1;  
  wire signed [35:0] Product1_out1;  
  wire signed [35:0] Add1_out1;  
  wire signed [35:0] Product2_out1;  
  wire signed [35:0] Product3_out1;  
  wire signed [35:0] Add2_out1;  
  assign Product_out1 = In1_re * In2_re;
  assign Product1_out1 = In1_im * In2_im;
  assign Add1_out1 = Product_out1 - Product1_out1;
  assign Re = Add1_out1;
  assign Product2_out1 = In1_re * In2_im;
  assign Product3_out1 = In1_im * In2_re;
  assign Add2_out1 = Product2_out1 + Product3_out1;
  assign Im = Add2_out1;
endmodule