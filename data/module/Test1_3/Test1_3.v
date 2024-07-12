module Test1_3 #(
  parameter DW = 4
)(
  input  wire [DW-1:0] drv_a,
  input  wire [DW-1:0] drv_b,
  input  wire [DW-1:0] drv_e,
  inout  wire [DW-1:0] drv
);
   wire   drv_0, drv_1, drv_2, drv_3;
   bufif1 bufa0  (drv_0, drv_a[0],  drv_e[0]);
   bufif1 bufb0  (drv_0, drv_b[0], ~drv_e[0]);
   bufif1 bufa1  (drv_1, drv_a[1],  drv_e[1]);
   bufif1 bufb1  (drv_1, drv_b[1], ~drv_e[1]);
   bufif1 bufa2  (drv_2, drv_a[2],  drv_e[2]);
   bufif1 bufb2  (drv_2, drv_b[2], ~drv_e[2]);
   bufif1
     bufa3  (drv_3, drv_a[3],  drv_e[3]),
     bufb3  (drv_3, drv_b[3], ~drv_e[3]);
   assign drv = {drv_3,drv_2,drv_1,drv_0};
endmodule