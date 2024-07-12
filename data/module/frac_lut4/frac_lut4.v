module frac_lut4(
   input [0:3] in,
   output [0:1] lut2_out,
   output lut4_out
);
    parameter [0:15] LUT = 0;
    wire [0:3] li = in;
    wire [0:7] s1 = li[0] ?
        {LUT[0], LUT[2], LUT[4], LUT[6], LUT[8], LUT[10], LUT[12], LUT[14]}:
        {LUT[1], LUT[3], LUT[5], LUT[7], LUT[9], LUT[11], LUT[13], LUT[15]};
    wire [0:3] s2 = li[1] ? {s1[0], s1[2], s1[4], s1[6]} : 
                            {s1[1], s1[3], s1[5], s1[7]};
    wire [0:1] s3 = li[2] ? {s2[0], s2[2]} : {s2[1], s2[3]};
    assign lut2_out[0] = s2[2];
    assign lut2_out[1] = s2[3];
    assign  lut4_out = li[3] ? s3[0] : s3[1];
endmodule