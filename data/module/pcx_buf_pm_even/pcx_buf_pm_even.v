module pcx_buf_pm_even(
   arbpc0_pcxdp_grant_pa, arbpc0_pcxdp_q0_hold_pa_l, 
   arbpc0_pcxdp_qsel0_pa, arbpc0_pcxdp_qsel1_pa_l, 
   arbpc0_pcxdp_shift_px, arbpc2_pcxdp_grant_pa, 
   arbpc2_pcxdp_q0_hold_pa_l, arbpc2_pcxdp_qsel0_pa, 
   arbpc2_pcxdp_qsel1_pa_l, arbpc2_pcxdp_shift_px, 
   arbpc0_pcxdp_grant_arbbf_pa, arbpc0_pcxdp_q0_hold_arbbf_pa_l, 
   arbpc0_pcxdp_qsel0_arbbf_pa, arbpc0_pcxdp_qsel1_arbbf_pa_l, 
   arbpc0_pcxdp_shift_arbbf_px, arbpc2_pcxdp_grant_arbbf_pa, 
   arbpc2_pcxdp_q0_hold_arbbf_pa_l, arbpc2_pcxdp_qsel0_arbbf_pa, 
   arbpc2_pcxdp_qsel1_arbbf_pa_l, arbpc2_pcxdp_shift_arbbf_px
   );
   output 		arbpc0_pcxdp_grant_pa		;	
   output 		arbpc0_pcxdp_q0_hold_pa_l		;
   output 		arbpc0_pcxdp_qsel0_pa		;	
   output 		arbpc0_pcxdp_qsel1_pa_l		;	
   output 		arbpc0_pcxdp_shift_px		;	
   output 		arbpc2_pcxdp_grant_pa		;	
   output 		arbpc2_pcxdp_q0_hold_pa_l		;
   output 		arbpc2_pcxdp_qsel0_pa		;	
   output 		arbpc2_pcxdp_qsel1_pa_l		;	
   output 		arbpc2_pcxdp_shift_px		;	
   input 		arbpc0_pcxdp_grant_arbbf_pa;	
   input 		arbpc0_pcxdp_q0_hold_arbbf_pa_l;
   input 		arbpc0_pcxdp_qsel0_arbbf_pa;	
   input 		arbpc0_pcxdp_qsel1_arbbf_pa_l;	
   input 		arbpc0_pcxdp_shift_arbbf_px;	
   input 		arbpc2_pcxdp_grant_arbbf_pa;	
   input 		arbpc2_pcxdp_q0_hold_arbbf_pa_l;
   input 		arbpc2_pcxdp_qsel0_arbbf_pa;	
   input 		arbpc2_pcxdp_qsel1_arbbf_pa_l;	
   input 		arbpc2_pcxdp_shift_arbbf_px;	
   assign		arbpc0_pcxdp_grant_pa	   =         arbpc0_pcxdp_grant_arbbf_pa;      	
   assign		arbpc0_pcxdp_q0_hold_pa_l  =        arbpc0_pcxdp_q0_hold_arbbf_pa_l;  
   assign		arbpc0_pcxdp_qsel0_pa	   =        arbpc0_pcxdp_qsel0_arbbf_pa;      
   assign		arbpc0_pcxdp_qsel1_pa_l	   =        arbpc0_pcxdp_qsel1_arbbf_pa_l;    
   assign		arbpc0_pcxdp_shift_px	   =        arbpc0_pcxdp_shift_arbbf_px;      
   assign		arbpc2_pcxdp_grant_pa	   =         arbpc2_pcxdp_grant_arbbf_pa;      	
   assign		arbpc2_pcxdp_q0_hold_pa_l  =        arbpc2_pcxdp_q0_hold_arbbf_pa_l;  
   assign		arbpc2_pcxdp_qsel0_pa	   =        arbpc2_pcxdp_qsel0_arbbf_pa;      
   assign		arbpc2_pcxdp_qsel1_pa_l	   =        arbpc2_pcxdp_qsel1_arbbf_pa_l;    
   assign		arbpc2_pcxdp_shift_px	   =        arbpc2_pcxdp_shift_arbbf_px;      
endmodule