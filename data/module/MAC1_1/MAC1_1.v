module MAC1_1
  (
   OutData, output_Valid,
   CLK, ARST, input_Valid, initialize, InData, filterCoef
   );
   input                               CLK                     ;  
   input                               ARST                    ;
   input                               input_Valid             ;
   input                               initialize              ;
   input   signed [(15):0] 	       InData, filterCoef      ;
   output  signed [(31):0] 	       OutData                 ;
   output                              output_Valid            ;
   reg     signed [(31):0] 	       mult            ;
   reg signed [31:0] 		       accum;
   reg                                 input_Valid0            ;
   reg                                 initialize1             ;
   reg                                 output_Valid_1          ;
   wire                                output_Valid            ;
   reg [3:0] 			       count                   ;
   wire    signed [(31):0] 	       accum_tmp               ;
   wire [3:0] 			       taps                    ;
   always @(posedge CLK or posedge ARST)
     if (ARST)     input_Valid0 <=  1'b0 ;
     else          input_Valid0 <=  input_Valid ;
   always @(posedge CLK or posedge ARST)
     if (ARST)     initialize1 <=  1'b0 ;
     else          initialize1 <=  initialize ;
   always @(posedge CLK or posedge ARST)
     if (ARST)     mult[(31):0] <=  {(31){1'b0}} ;
     else          mult[(31):0] <=  filterCoef*InData  ;
   assign  accum_tmp[(31):0] =   mult[(31):0] + accum[(31):0];
   always @(posedge CLK or posedge ARST)
     if (ARST)       accum[(31):0] <=  {(32){1'b0}} ;
     else            accum[(31):0] <=  (initialize1) ?
				       mult[31:0] :
				       (input_Valid0 ? accum_tmp[31:0]
					: accum[31:0]) ;
   always @ (posedge CLK or posedge ARST)
     if (ARST )     count[3:0] <=  {(4){1'b0}}  ;
     else           count[3:0] <= initialize ?
                                  0 :
                                  input_Valid0 + count[3:0] ;
   always @(posedge CLK or posedge ARST)
     if (ARST)     output_Valid_1 <=  1'b0 ;
     else          output_Valid_1 <=  (count[3:0]==(14))   ;
   assign  output_Valid            = output_Valid_1 & (count[3:0]==0) ;
   assign  OutData[31:0]           = accum[31:0]                          ;
endmodule