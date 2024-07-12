module oh_add #(parameter DW = 1 
		)
   (
    input [DW-1:0]  a, 
    input [DW-1:0]  b, 
    input 	    opt_sub, 
    input 	    cin, 
    output [DW-1:0] sum, 
    output 	    cout, 
    output 	    zero, 
    output 	    neg, 
    output 	    overflow 
    );
   wire [DW-1:0]   b_sub;
   assign b_sub[DW-1:0] =  {(DW){opt_sub}} ^ b[DW-1:0];
   assign {cout,sum[DW-1:0]}  = a[DW-1:0]     + 
                                b_sub[DW-1:0] + 
                                opt_sub       +
                                cin;
endmodule