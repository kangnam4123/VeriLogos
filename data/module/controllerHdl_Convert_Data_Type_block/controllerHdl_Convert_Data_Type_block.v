module controllerHdl_Convert_Data_Type_block
          (
           In1,
           Out1
          );
  input   signed [31:0] In1;  
  output  signed [17:0] Out1;  
  wire signed [17:0] Data_Type_Conversion_out1;  
  assign Data_Type_Conversion_out1 = In1[31:14];
  assign Out1 = Data_Type_Conversion_out1;
endmodule