module adrlat(
              input [7:0] i,
              inout [7:0] o,
              input oeb,
              input lat_en
              );
  reg [7:0]         lat_q;
  assign o = (oeb) ? 8'bz : lat_q;
  always @ ( *  )
    if (lat_en)
      lat_q <= i;
endmodule