module OptimizationBarrier(
  input  [19:0] io_x_ppn,
  input         io_x_u,
  input         io_x_ae_ptw,
  input         io_x_ae_final,
  input         io_x_gf,
  input         io_x_sx,
  input         io_x_px,
  output [19:0] io_y_ppn,
  output        io_y_u,
  output        io_y_ae_ptw,
  output        io_y_ae_final,
  output        io_y_gf,
  output        io_y_sx,
  output        io_y_px
);
  assign io_y_ppn = io_x_ppn; 
  assign io_y_u = io_x_u; 
  assign io_y_ae_ptw = io_x_ae_ptw; 
  assign io_y_ae_final = io_x_ae_final; 
  assign io_y_gf = io_x_gf; 
  assign io_y_sx = io_x_sx; 
  assign io_y_px = io_x_px; 
endmodule