module dram_async_edgelogic(
   to_pad, 
   data
   );
input			data;
output			to_pad;
wire n0 = data;
assign to_pad  = n0;
endmodule