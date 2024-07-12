module DecodeUnitRegisterOne(
   input 	CLK, One_A_IN, One_B_IN, Two_A_IN, Two_B_IN, MW_One_IN, MW_Two_IN,
   input 	input_IN, wren_IN,
   input [2:0] 	writeAd_IN,
   input 	ADR_MUX_IN, write_IN, PC_load_IN,
   input 	SPR_w_IN, SPR_i_IN, SPR_d_IN,
   input [2:0] 	cond_IN, op2_IN,
   input 	SW_IN, MAD_MUX_IN, FLAG_WRITE_IN, AR_IN, BR_IN,
   input [3:0] 	ALU_IN,
   input 	SPC_MUX_IN, MX_MUX_IN, AB_MUX_IN,
   output       One_A_OUT, One_B_OUT, Two_A_OUT, Two_B_OUT, MW_One_OUT, MW_Two_OUT,
   output 	input_OUT, wren_OUT,
   output [2:0] writeAd_OUT,
   output 	ADR_MUX_OUT, write_OUT, PC_load_OUT,
   output 	SPR_w_OUT, SPR_i_OUT, SPR_d_OUT,
   output [2:0] cond_OUT, op2_OUT,
   output 	SW_OUT, MAD_MUX_OUT, FLAG_WRITE_OUT, AR_OUT, BR_OUT,
   output [3:0] ALU_OUT,
   output 	SPC_MUX_OUT, MX_MUX_OUT, AB_MUX_OUT);
   reg          oa, ob, ta, tb;
   reg          ar, br;
   reg [3:0]    alu;
   reg          in, wren;
   reg [2:0]    writeAd;
   reg          adrmux, write, pcload;
   reg [2:0] 	cond, opera2;
   reg 		sprw,spri,sprd;
   reg 		sw, mad, flw;
   reg 		spc, mx, ab;
   reg		mwo, mwt;
   always @ (posedge CLK) begin
      mwo <= MW_One_IN;
      mwt <= MW_Two_IN;
      oa <= One_A_IN;
      ob <= One_B_IN;
      ta <= Two_A_IN;
      tb <= Two_B_IN;
      ar <= AR_IN;
      br <= BR_IN;
      alu <= ALU_IN;
      in <= input_IN;
      wren <= wren_IN;
      writeAd <= writeAd_IN;
      adrmux <= ADR_MUX_IN;
      write <= write_IN;
      pcload <= PC_load_IN;
      cond <= cond_IN;
      opera2 <= op2_IN;
      sprw <= SPR_w_IN;
      spri <= SPR_i_IN;
      sprd <= SPR_d_IN;
      sw <= SW_IN;
      mad <= MAD_MUX_IN;
      spc <= SPC_MUX_IN;
      mx <= MX_MUX_IN;
      ab <= AB_MUX_IN;
      flw <= FLAG_WRITE_IN;
   end 
   assign MW_One_OUT = mwo;
   assign MW_Two_OUT = mwt;
   assign One_A_OUT = oa;
   assign One_B_OUT = ob;
   assign Two_A_OUT = ta;
   assign Two_B_OUT = tb;
   assign AR_OUT = ar;
   assign BR_OUT = br;
   assign ALU_OUT = alu;
   assign input_OUT = in;
   assign wren_OUT = wren;
   assign writeAd_OUT = writeAd;
   assign ADR_MUX_OUT = adrmux;
   assign write_OUT = write;
   assign PC_load_OUT = pcload;
   assign cond_OUT = cond;
   assign op2_OUT = opera2;
   assign SPR_w_OUT = sprw;
   assign SPR_i_OUT = spri;
   assign SPR_d_OUT = sprd;
   assign SW_OUT = sw;
   assign MAD_MUX_OUT = mad;
   assign FLAG_WRITE_OUT = flw;
   assign SPC_MUX_OUT = spc;
   assign MX_MUX_OUT = mx;
   assign AB_MUX_OUT = ab;
endmodule