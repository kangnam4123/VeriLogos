module pcx_buf_pdr_odd(
   arbpc1_pcxdp_grant_pa, arbpc1_pcxdp_q0_hold_pa_l, 
   arbpc1_pcxdp_qsel0_pa, arbpc1_pcxdp_qsel1_pa_l, 
   arbpc1_pcxdp_shift_px, arbpc3_pcxdp_grant_pa, 
   arbpc3_pcxdp_q0_hold_pa_l, arbpc3_pcxdp_qsel0_pa, 
   arbpc3_pcxdp_qsel1_pa_l, arbpc3_pcxdp_shift_px, 
   arbpc4_pcxdp_grant_pa, arbpc4_pcxdp_q0_hold_pa_l, 
   arbpc4_pcxdp_qsel0_pa, arbpc4_pcxdp_qsel1_pa_l, 
   arbpc4_pcxdp_shift_px, 
   arbpc1_pcxdp_grant_bufp3_pa_l, arbpc1_pcxdp_q0_hold_bufp3_pa, 
   arbpc1_pcxdp_qsel0_bufp3_pa_l, arbpc1_pcxdp_qsel1_bufp3_pa, 
   arbpc1_pcxdp_shift_bufp3_px_l, arbpc3_pcxdp_grant_bufp3_pa_l, 
   arbpc3_pcxdp_q0_hold_bufp3_pa, arbpc3_pcxdp_qsel0_bufp3_pa_l, 
   arbpc3_pcxdp_qsel1_bufp3_pa, arbpc3_pcxdp_shift_bufp3_px_l, 
   arbpc4_pcxdp_grant_bufp3_pa_l, arbpc4_pcxdp_q0_hold_bufp3_pa, 
   arbpc4_pcxdp_qsel0_bufp3_pa_l, arbpc4_pcxdp_qsel1_bufp3_pa, 
   arbpc4_pcxdp_shift_bufp3_px_l
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
   input 		arbpc1_pcxdp_grant_bufp3_pa_l;	
   input 		arbpc1_pcxdp_q0_hold_bufp3_pa;
   input 		arbpc1_pcxdp_qsel0_bufp3_pa_l;	
   input 		arbpc1_pcxdp_qsel1_bufp3_pa;	
   input 		arbpc1_pcxdp_shift_bufp3_px_l;	
   input 		arbpc3_pcxdp_grant_bufp3_pa_l;	
   input 		arbpc3_pcxdp_q0_hold_bufp3_pa;
   input 		arbpc3_pcxdp_qsel0_bufp3_pa_l;	
   input 		arbpc3_pcxdp_qsel1_bufp3_pa;	
   input 		arbpc3_pcxdp_shift_bufp3_px_l;	
   input 		arbpc4_pcxdp_grant_bufp3_pa_l;	
   input 		arbpc4_pcxdp_q0_hold_bufp3_pa;
   input 		arbpc4_pcxdp_qsel0_bufp3_pa_l;	
   input 		arbpc4_pcxdp_qsel1_bufp3_pa;	
   input 		arbpc4_pcxdp_shift_bufp3_px_l;	
   assign		arbpc1_pcxdp_grant_pa	   =        ~arbpc1_pcxdp_grant_bufp3_pa_l;      	
   assign		arbpc1_pcxdp_q0_hold_pa_l  =        ~arbpc1_pcxdp_q0_hold_bufp3_pa;  
   assign		arbpc1_pcxdp_qsel0_pa	   =        ~arbpc1_pcxdp_qsel0_bufp3_pa_l;      
   assign		arbpc1_pcxdp_qsel1_pa_l	   =        ~arbpc1_pcxdp_qsel1_bufp3_pa;    
   assign		arbpc1_pcxdp_shift_px	   =        ~arbpc1_pcxdp_shift_bufp3_px_l;      
   assign		arbpc3_pcxdp_grant_pa	   =        ~arbpc3_pcxdp_grant_bufp3_pa_l;      	
   assign		arbpc3_pcxdp_q0_hold_pa_l  =        ~arbpc3_pcxdp_q0_hold_bufp3_pa;  
   assign		arbpc3_pcxdp_qsel0_pa	   =        ~arbpc3_pcxdp_qsel0_bufp3_pa_l;      
   assign		arbpc3_pcxdp_qsel1_pa_l	   =        ~arbpc3_pcxdp_qsel1_bufp3_pa;    
   assign		arbpc3_pcxdp_shift_px	   =        ~arbpc3_pcxdp_shift_bufp3_px_l;      
   assign		arbpc4_pcxdp_grant_pa	   =        ~arbpc4_pcxdp_grant_bufp3_pa_l;      	
   assign		arbpc4_pcxdp_q0_hold_pa_l  =        ~arbpc4_pcxdp_q0_hold_bufp3_pa;  
   assign		arbpc4_pcxdp_qsel0_pa	   =        ~arbpc4_pcxdp_qsel0_bufp3_pa_l;      
   assign		arbpc4_pcxdp_qsel1_pa_l	   =        ~arbpc4_pcxdp_qsel1_bufp3_pa;    
   assign		arbpc4_pcxdp_shift_px	   =        ~arbpc4_pcxdp_shift_bufp3_px_l;      
endmodule