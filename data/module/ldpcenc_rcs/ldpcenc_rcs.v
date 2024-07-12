module ldpcenc_rcs (
    input [80:0] d_in,          
    input z54,                  
    input [7:0] sh,             
    output [80:0] d_out         
);
wire [80:0] dc;
wire [80:0] d0, d1, d2, d3, d4, d5, d6;
wire [53:0] d0_54, d1_54, d2_54, d3_54, d4_54, d5_54;
wire [53:0] mux_d54;
assign dc = (sh[7]) ? d_in : 81'd0;
assign d0 = (sh[0]) ? {dc[0], dc[80:1]} : dc;
assign d1 = (sh[1]) ? {d0[1:0], d0[80:2]} : d0;
assign d2 = (sh[2]) ? {d1[3:0], d1[80:4]} : d1;
assign d3 = (sh[3]) ? {d2[7:0], d2[80:8]} : d2;
assign d4 = (sh[4]) ? {d3[15:0], d3[80:16]} : d3;
assign d5 = (sh[5]) ? {d4[31:0], d4[80:32]} : d4;
assign d6 = (sh[6]) ? {d5[63:0], d5[80:64]} : d5;
assign d0_54 = (sh[0]) ? {dc[0], dc[53:1]} : dc[53:0];
assign d1_54 = (sh[1]) ? {d0_54[1:0], d0_54[53:2]} : d0_54;
assign d2_54 = (sh[2]) ? {d1_54[3:0], d1_54[53:4]} : d1_54;
assign d3_54 = (sh[3]) ? {d2_54[7:0], d2_54[53:8]} : d2_54;
assign d4_54 = (sh[4]) ? {d3_54[15:0], d3_54[53:16]} : d3_54;
assign d5_54 = (sh[5]) ? {d4_54[31:0], d4_54[53:32]} : d4_54;
assign mux_d54 = (z54) ? d5_54 : d6[53:0];
assign d_out = {d6[80:54], mux_d54};
endmodule