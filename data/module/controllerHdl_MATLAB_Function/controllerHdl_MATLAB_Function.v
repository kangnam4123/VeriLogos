module controllerHdl_MATLAB_Function
          (
           u,
           y
          );
  input   [35:0] u;  
  output  [17:0] y;  
  assign y = u[17:0];
endmodule