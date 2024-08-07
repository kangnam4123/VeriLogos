module JTA23NN(ENC_, OT, X);
input   ENC_;
input   OT;
output  X;
wire	OT_ ;
wire	tmg1m1_out ;
wire	tmg1m1_out_ ;
wire	ENC ;
wire	bscn_d_xd0 ;
wire	bscn_d_d0 ;
wire	bscn_d_xd1 ;
wire	bscn_d_d1 ;
wire	out_buf_o_a ;
wire	out_buf_o_b ;
wire	out_buf_o_en ;
  not		g1(OT_,  OT)  ;
  not		g2(tmg1m1_out, OT_) ;
  not		g3(ENC, ENC_) ;
  not		g4(tmg1m1_out_, tmg1m1_out) ;
  and		g5(bscn_d_xd0, ENC, tmg1m1_out) ;
  or		g6(bscn_d_d0, ENC_, tmg1m1_out_) ;
  or		g7(bscn_d_xd1, ENC_, tmg1m1_out) ;
  and		g8(bscn_d_d1, ENC, tmg1m1_out_) ;
  not		g9(out_buf_o_a, bscn_d_xd0) ;
  not		g10(out_buf_o_b, bscn_d_xd1) ;
  xor		g11(out_buf_o_en, out_buf_o_a, out_buf_o_b) ;
  notif0	g12(X, out_buf_o_a, out_buf_o_en) ;
endmodule