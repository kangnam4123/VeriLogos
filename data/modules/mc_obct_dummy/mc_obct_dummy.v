module mc_obct_dummy(clk, rst, row_adr, bank_adr, bank_set, bank_clr, bank_clr_all,
		bank_open, any_bank_open, row_same);
input		clk, rst;
input	[12:0]	row_adr;
input	[1:0]	bank_adr;
input		bank_set;
input		bank_clr;
input		bank_clr_all;
output		bank_open;
output		any_bank_open;
output		row_same;
assign bank_open = 1'b0;
assign any_bank_open = 1'b0;
assign row_same = 1'b0;
endmodule