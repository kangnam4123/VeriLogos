module LUT4_5 (output dout,
             input  din0, din1, din2, din3);
parameter [15:0] lut_function = 16'hFFFF;
reg combout_rt;
wire dataa_w;
wire datab_w;
wire datac_w;
wire datad_w;
assign dataa_w = din0;
assign datab_w = din1;
assign datac_w = din2;
assign datad_w = din3;
function lut_data;
input [15:0] mask;
input        dataa, datab, datac, datad;
reg [7:0]   s3;
reg [3:0]   s2;
reg [1:0]   s1;
  begin
       s3 = datad ? mask[15:8] : mask[7:0];
       s2 = datac ?   s3[7:4]  :   s3[3:0];
       s1 = datab ?   s2[3:2]  :   s2[1:0];
       lut_data = dataa ? s1[1] : s1[0];
  end
endfunction
always @(dataa_w or datab_w or datac_w or datad_w) begin
   combout_rt = lut_data(lut_function, dataa_w, datab_w,
                         datac_w, datad_w);
end
assign dout = combout_rt & 1'b1;
endmodule