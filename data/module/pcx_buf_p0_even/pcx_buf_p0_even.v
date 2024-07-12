module pcx_buf_p0_even(
   arbpc0_pcxdp_grant_pa, arbpc0_pcxdp_q0_hold_pa_l, 
   arbpc0_pcxdp_qsel0_pa, arbpc0_pcxdp_qsel1_pa_l, 
   arbpc0_pcxdp_shift_px, arbpc2_pcxdp_grant_pa, 
   arbpc2_pcxdp_q0_hold_pa_l, arbpc2_pcxdp_qsel0_pa, 
   arbpc2_pcxdp_qsel1_pa_l, arbpc2_pcxdp_shift_px, 
   scache0_pcx_stall_bufp0even_pq, 
   arbpc0_pcxdp_grant_bufp1_pa_l, arbpc0_pcxdp_q0_hold_bufp1_pa, 
   arbpc0_pcxdp_qsel0_bufp1_pa_l, arbpc0_pcxdp_qsel1_bufp1_pa, 
   arbpc0_pcxdp_shift_bufp1_px_l, arbpc2_pcxdp_grant_bufp1_pa_l, 
   arbpc2_pcxdp_q0_hold_bufp1_pa, arbpc2_pcxdp_qsel0_bufp1_pa_l, 
   arbpc2_pcxdp_qsel1_bufp1_pa, arbpc2_pcxdp_shift_bufp1_px_l, 
   scache0_pcx_stall_pq
   );
   output 		arbpc0_pcxdp_grant_pa;	
   output 		arbpc0_pcxdp_q0_hold_pa_l;
   output 		arbpc0_pcxdp_qsel0_pa;	
   output 		arbpc0_pcxdp_qsel1_pa_l;	
   output 		arbpc0_pcxdp_shift_px;	
   output 		arbpc2_pcxdp_grant_pa;	
   output 		arbpc2_pcxdp_q0_hold_pa_l;
   output 		arbpc2_pcxdp_qsel0_pa;	
   output 		arbpc2_pcxdp_qsel1_pa_l;	
   output 		arbpc2_pcxdp_shift_px;	
   output 		scache0_pcx_stall_bufp0even_pq;	
   input		arbpc0_pcxdp_grant_bufp1_pa_l;	
   input		arbpc0_pcxdp_q0_hold_bufp1_pa;
   input		arbpc0_pcxdp_qsel0_bufp1_pa_l;	
   input		arbpc0_pcxdp_qsel1_bufp1_pa;	
   input		arbpc0_pcxdp_shift_bufp1_px_l;	
   input		arbpc2_pcxdp_grant_bufp1_pa_l;	
   input		arbpc2_pcxdp_q0_hold_bufp1_pa;
   input		arbpc2_pcxdp_qsel0_bufp1_pa_l;	
   input		arbpc2_pcxdp_qsel1_bufp1_pa;	
   input		arbpc2_pcxdp_shift_bufp1_px_l;	
   input		scache0_pcx_stall_pq;	
   assign		arbpc0_pcxdp_grant_pa		   =    ~arbpc0_pcxdp_grant_bufp1_pa_l;      	
   assign		arbpc0_pcxdp_q0_hold_pa_l	   =    ~arbpc0_pcxdp_q0_hold_bufp1_pa;
   assign		arbpc0_pcxdp_qsel0_pa		   =    ~arbpc0_pcxdp_qsel0_bufp1_pa_l;
   assign		arbpc0_pcxdp_qsel1_pa_l		   =    ~arbpc0_pcxdp_qsel1_bufp1_pa;
   assign		arbpc0_pcxdp_shift_px		   =    ~arbpc0_pcxdp_shift_bufp1_px_l;
   assign		arbpc2_pcxdp_grant_pa		   =    ~arbpc2_pcxdp_grant_bufp1_pa_l;      	
   assign		arbpc2_pcxdp_q0_hold_pa_l	   =    ~arbpc2_pcxdp_q0_hold_bufp1_pa;
   assign		arbpc2_pcxdp_qsel0_pa		   =    ~arbpc2_pcxdp_qsel0_bufp1_pa_l;
   assign		arbpc2_pcxdp_qsel1_pa_l		   =    ~arbpc2_pcxdp_qsel1_bufp1_pa;
   assign		arbpc2_pcxdp_shift_px		   =    ~arbpc2_pcxdp_shift_bufp1_px_l;
   assign		scache0_pcx_stall_bufp0even_pq	   =    scache0_pcx_stall_pq;
endmodule