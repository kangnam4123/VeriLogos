module my_SRL16E_2 #(
   parameter INIT = 16'h0000 
   )( 
     output Q,
     input A0,
     input A1,
     input A2,
     input A3,
     input CE,
     input CLK,
     input RST_N,
     input D
   );
    reg  [15:0] data = INIT;
    assign Q = data[{A3, A2, A1, A0}];
    always @(posedge CLK)
    begin
        if (RST_N == 1'b0)
            {data[15:0]} <= #1 INIT; 
        else
           if (CE == 1'b1) begin
               {data[15:0]} <= #1 {data[14:0], D};
           end
    end
endmodule