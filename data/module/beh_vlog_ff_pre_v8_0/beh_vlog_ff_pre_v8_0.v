module beh_vlog_ff_pre_v8_0 (Q, C, D, PRE);
  parameter INIT = 0;
localparam FLOP_DELAY = 100;
    output Q;
    input  C, D, PRE;
    reg Q;
    initial Q= 1'b0;
    always @(posedge C )
      if (PRE)
           Q <= 1'b1;
      else
	   Q <= #FLOP_DELAY D;
endmodule