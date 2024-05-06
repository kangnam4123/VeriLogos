module test_stub_scan (
mux_drive_disable, mem_write_disable, sehold, se, testmode_l, 
mem_bypass, so_0, so_1, so_2, 
ctu_tst_pre_grst_l, arst_l, global_shift_enable, 
ctu_tst_scan_disable, ctu_tst_scanmode, ctu_tst_macrotest, 
ctu_tst_short_chain, long_chain_so_0, short_chain_so_0, 
long_chain_so_1, short_chain_so_1, long_chain_so_2, short_chain_so_2
);
   input        ctu_tst_pre_grst_l;
   input        arst_l;                
   input        global_shift_enable;
   input        ctu_tst_scan_disable;  
   input        ctu_tst_scanmode;
   input 	ctu_tst_macrotest;
   input 	ctu_tst_short_chain;
   input 	long_chain_so_0;
   input 	short_chain_so_0;
   input 	long_chain_so_1;
   input 	short_chain_so_1;
   input 	long_chain_so_2;
   input 	short_chain_so_2;
   output 	mux_drive_disable;
   output 	mem_write_disable;
   output 	sehold;
   output 	se;
   output 	testmode_l;
   output 	mem_bypass;
   output 	so_0;
   output 	so_1;
   output 	so_2;
   wire         pin_based_scan;
   wire         short_chain_en;
   wire         short_chain_select;
   assign  mux_drive_disable  = ~ctu_tst_pre_grst_l | short_chain_select | se;
   assign  mem_write_disable  = ~ctu_tst_pre_grst_l | se;
   assign  sehold             = ctu_tst_macrotest & ~se;
   assign  se                 = global_shift_enable;
   assign  testmode_l         = ~ctu_tst_scanmode;
   assign  mem_bypass         = ~ctu_tst_macrotest & ~testmode_l;
   assign  pin_based_scan     = ctu_tst_scan_disable;
   assign  short_chain_en     = ~(pin_based_scan & se);
   assign  short_chain_select = ctu_tst_short_chain & ~testmode_l & short_chain_en;
   assign  so_0               = short_chain_select ? short_chain_so_0 : long_chain_so_0;
   assign  so_1               = short_chain_select ? short_chain_so_1 : long_chain_so_1;
   assign  so_2               = short_chain_select ? short_chain_so_2 : long_chain_so_2;
endmodule