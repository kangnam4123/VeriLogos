module channelizer_xldpram  (dina, addra, wea, a_ce, a_clk, rsta, ena, douta, dinb, addrb, web, b_ce, b_clk, rstb, enb, doutb);
 parameter core_name0= "";
 parameter c_width_a= 13;
 parameter c_address_width_a= 4;
 parameter c_width_b= 13;
 parameter c_address_width_b= 4;
 parameter latency= 1;
 input [c_width_a-1:0] dina;
 input [c_address_width_a-1:0] addra;
 input wea, a_ce, a_clk, rsta, ena;
 input [c_width_b-1:0] dinb;
 input [c_address_width_b-1:0] addrb;
 input web, b_ce, b_clk, rstb, enb;
 output [c_width_a-1:0] douta;
 output [c_width_b-1:0] doutb;
 wire [c_address_width_a-1:0] core_addra;
 wire [c_address_width_b-1:0] core_addrb;
 wire [c_width_a-1:0] core_dina,core_douta,dly_douta;
 wire [c_width_b-1:0] core_dinb,core_doutb,dly_doutb;
 wire  core_wea,core_web;
 wire  core_a_ce,core_b_ce;
 wire  sinita,sinitb;
 assign core_addra = addra;
 assign core_dina = dina;
 assign douta = dly_douta;
 assign core_wea = wea;
 assign core_a_ce = a_ce & ena;
 assign sinita = rsta & a_ce;
 assign core_addrb = addrb;
 assign core_dinb = dinb;
 assign doutb = dly_doutb;
 assign core_web = web;
 assign core_b_ce = b_ce & enb;
 assign sinitb = rstb  & b_ce;
 generate
if (core_name0 == "channelizer_blk_mem_gen_v8_2_0") 
     begin:comp0
channelizer_blk_mem_gen_v8_2_0 core_instance0 ( 
      .addra(core_addra),
      .clka(a_clk),
      .addrb(core_addrb),
      .clkb(b_clk),
      .dina(core_dina),
      .wea(core_wea),
      .dinb(core_dinb),
      .web(core_web),
      .ena(core_a_ce),
      .enb(core_b_ce),
      .rsta(sinita),
      .rstb(sinitb),
      .douta(core_douta),
      .doutb(core_doutb) 
       ); 
     end 
 if (latency > 2)
   begin:latency_test_instA
    synth_reg # (c_width_a, latency-2) 
    regA(
      .i(core_douta),
      .ce(core_a_ce),
      .clr(1'b0),
      .clk(a_clk),
      .o(dly_douta));
   end
 if (latency > 2)
   begin:latency_test_instB
    synth_reg # (c_width_b, latency-2) 
    regB(
      .i(core_doutb),
      .ce(core_b_ce),
      .clr(1'b0),
      .clk(b_clk),
      .o(dly_doutb));
   end
 if (latency <= 2)
    begin:latency1
      assign dly_douta = core_douta;
      assign dly_doutb = core_doutb;
    end
 endgenerate
 endmodule