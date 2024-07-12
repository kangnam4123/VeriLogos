module controllerHdl_MATLAB_Function_block1
          (
           u,
           y
          );
  input   [17:0] u;  
  output  [8:0] y;  
  assign y = u[8:0];
endmodule