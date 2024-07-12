module JOS13NN(OT, X);
input   OT;
output  X;
wire	OT_ ;
wire	tmg1m1n_out ;
wire	tmg1m1n_out_ ;
wire	ENC ;
wire	bscn_xd0 ;
wire	bscn_d0 ;
wire	bscn_xd1 ;
wire	bscn_d1 ;
wire	out_buf_a ;
wire	out_buf_b ;
wire	out_buf_en ;
  not		g1(OT_, OT) ;
  not		g2(tmg1m1n_out, OT_) ;
  not		g3(ENC, 1'b0) ;
  not		g4(tmg1m1n_out_, tmg1m1n_out) ;
  and		g5(bscn_xd0, ENC, tmg1m1n_out) ;
  or		g6(bscn_d0, 1'b0, tmg1m1n_out_) ;
  or		g7(bscn_xd1, 1'b0, tmg1m1n_out) ;
  and		g8(bscn_d1, ENC, tmg1m1n_out_) ;
  not		g9(out_buf_a, bscn_xd0) ;
  not		g10(out_buf_b, bscn_xd1) ;
  xor		g11(out_buf_en, out_buf_a, out_buf_b) ;
  notif0	g12(X, out_buf_a, out_buf_en) ;
endmodule