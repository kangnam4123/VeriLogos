module bw_iodll(
        bypass_data,
	ddr_clk_in,
	ddr_testmode_l,
	delay_ctrl,
	io_dll_bypass_l,
	io_dll_reset_l,
	se,
	si,
	iodll_lock,	
	lpf_out,
	overflow,
	so,
	strobe
          );
	input [4:0]     bypass_data;
	input		ddr_clk_in;
	input		ddr_testmode_l;
	input [2:0]     delay_ctrl;
	input           io_dll_bypass_l;
	input		io_dll_reset_l;
	input		se;
	input		si;
	output		iodll_lock;
	output [4:0] 	lpf_out;
	output		overflow;
	output		so;
	output		strobe;
assign lpf_out = (io_dll_bypass_l == 1'b0)? bypass_data:5'b00000;
endmodule