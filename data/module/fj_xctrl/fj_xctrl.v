module fj_xctrl(oe, en,en_);
output oe;
input  en, en_;
 assign oe = (en && (~en_));
endmodule