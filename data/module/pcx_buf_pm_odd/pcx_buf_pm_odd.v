module pcx_buf_pm_odd(
   arbpc1_pcxdp_grant_pa, arbpc1_pcxdp_q0_hold_pa_l, 
   arbpc1_pcxdp_qsel0_pa, arbpc1_pcxdp_qsel1_pa_l, 
   arbpc1_pcxdp_shift_px, arbpc3_pcxdp_grant_pa, 
   arbpc3_pcxdp_q0_hold_pa_l, arbpc3_pcxdp_qsel0_pa, 
   arbpc3_pcxdp_qsel1_pa_l, arbpc3_pcxdp_shift_px, 
   arbpc4_pcxdp_grant_pa, arbpc4_pcxdp_q0_hold_pa_l, 
   arbpc4_pcxdp_qsel0_pa, arbpc4_pcxdp_qsel1_pa_l, 
   arbpc4_pcxdp_shift_px, 
   arbpc1_pcxdp_grant_arbbf_pa, arbpc1_pcxdp_q0_hold_arbbf_pa_l, 
   arbpc1_pcxdp_qsel0_arbbf_pa, arbpc1_pcxdp_qsel1_arbbf_pa_l, 
   arbpc1_pcxdp_shift_arbbf_px, arbpc3_pcxdp_grant_arbbf_pa, 
   arbpc3_pcxdp_q0_hold_arbbf_pa_l, arbpc3_pcxdp_qsel0_arbbf_pa, 
   arbpc3_pcxdp_qsel1_arbbf_pa_l, arbpc3_pcxdp_shift_arbbf_px, 
   arbpc4_pcxdp_grant_arbbf_pa, arbpc4_pcxdp_q0_hold_arbbf_pa_l, 
   arbpc4_pcxdp_qsel0_arbbf_pa, arbpc4_pcxdp_qsel1_arbbf_pa_l, 
   arbpc4_pcxdp_shift_arbbf_px
   );
   output 		arbpc1_pcxdp_grant_pa		;	
   output 		arbpc1_pcxdp_q0_hold_pa_l		;
   output 		arbpc1_pcxdp_qsel0_pa		;	
   output 		arbpc1_pcxdp_qsel1_pa_l		;	
   output 		arbpc1_pcxdp_shift_px		;	
   output 		arbpc3_pcxdp_grant_pa		;	
   output 		arbpc3_pcxdp_q0_hold_pa_l		;
   output 		arbpc3_pcxdp_qsel0_pa		;	
   output 		arbpc3_pcxdp_qsel1_pa_l		;	
   output 		arbpc3_pcxdp_shift_px		;	
   output 		arbpc4_pcxdp_grant_pa		;	
   output 		arbpc4_pcxdp_q0_hold_pa_l		;
   output 		arbpc4_pcxdp_qsel0_pa		;	
   output 		arbpc4_pcxdp_qsel1_pa_l		;	
   output 		arbpc4_pcxdp_shift_px		;	
   input 		arbpc1_pcxdp_grant_arbbf_pa;	
   input 		arbpc1_pcxdp_q0_hold_arbbf_pa_l;
   input 		arbpc1_pcxdp_qsel0_arbbf_pa;	
   input 		arbpc1_pcxdp_qsel1_arbbf_pa_l;	
   input 		arbpc1_pcxdp_shift_arbbf_px;	
   input 		arbpc3_pcxdp_grant_arbbf_pa;	
   input 		arbpc3_pcxdp_q0_hold_arbbf_pa_l;
   input 		arbpc3_pcxdp_qsel0_arbbf_pa;	
   input 		arbpc3_pcxdp_qsel1_arbbf_pa_l;	
   input 		arbpc3_pcxdp_shift_arbbf_px;	
   input 		arbpc4_pcxdp_grant_arbbf_pa;	
   input 		arbpc4_pcxdp_q0_hold_arbbf_pa_l;
   input 		arbpc4_pcxdp_qsel0_arbbf_pa;	
   input 		arbpc4_pcxdp_qsel1_arbbf_pa_l;	
   input 		arbpc4_pcxdp_shift_arbbf_px;	
   assign		arbpc1_pcxdp_grant_pa	   =         arbpc1_pcxdp_grant_arbbf_pa;      	
   assign		arbpc1_pcxdp_q0_hold_pa_l  =        arbpc1_pcxdp_q0_hold_arbbf_pa_l;  
   assign		arbpc1_pcxdp_qsel0_pa	   =        arbpc1_pcxdp_qsel0_arbbf_pa;      
   assign		arbpc1_pcxdp_qsel1_pa_l	   =        arbpc1_pcxdp_qsel1_arbbf_pa_l;    
   assign		arbpc1_pcxdp_shift_px	   =        arbpc1_pcxdp_shift_arbbf_px;      
   assign		arbpc3_pcxdp_grant_pa	   =         arbpc3_pcxdp_grant_arbbf_pa;      	
   assign		arbpc3_pcxdp_q0_hold_pa_l  =        arbpc3_pcxdp_q0_hold_arbbf_pa_l;  
   assign		arbpc3_pcxdp_qsel0_pa	   =        arbpc3_pcxdp_qsel0_arbbf_pa;      
   assign		arbpc3_pcxdp_qsel1_pa_l	   =        arbpc3_pcxdp_qsel1_arbbf_pa_l;    
   assign		arbpc3_pcxdp_shift_px	   =        arbpc3_pcxdp_shift_arbbf_px;      
   assign		arbpc4_pcxdp_grant_pa	   =         arbpc4_pcxdp_grant_arbbf_pa;      	
   assign		arbpc4_pcxdp_q0_hold_pa_l  =        arbpc4_pcxdp_q0_hold_arbbf_pa_l;  
   assign		arbpc4_pcxdp_qsel0_pa	   =        arbpc4_pcxdp_qsel0_arbbf_pa;      
   assign		arbpc4_pcxdp_qsel1_pa_l	   =        arbpc4_pcxdp_qsel1_arbbf_pa_l;    
   assign		arbpc4_pcxdp_shift_px	   =        arbpc4_pcxdp_shift_arbbf_px;      
endmodule