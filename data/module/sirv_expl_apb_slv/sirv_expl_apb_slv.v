module sirv_expl_apb_slv #(
    parameter AW = 32,
    parameter DW = 32 
)(
  input  [AW-1:0] apb_paddr,
  input           apb_pwrite,
  input           apb_pselx,
  input           apb_penable,
  input  [DW-1:0] apb_pwdata,
  output [DW-1:0] apb_prdata,
  input  clk,  
  input  rst_n
);
  assign apb_prdata = {DW{1'b0}};
endmodule