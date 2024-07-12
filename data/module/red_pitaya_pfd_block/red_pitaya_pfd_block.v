module red_pitaya_pfd_block
#(
    parameter ISR = 0
)
(   input rstn_i,
    input clk_i, 
    input s1, 
    input s2, 
    output [14-1:0] integral_o
    );
reg l1; 
reg l2; 
wire e1;
wire e2;
reg [14+ISR-1:0] integral;
assign e1 = ( {s1,l1} == 2'b10 ) ? 1'b1 : 1'b0;
assign e2 = ( {s2,l2} == 2'b10 ) ? 1'b1 : 1'b0;
assign integral_o = integral[14+ISR-1:ISR];
always @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        l1 <= 1'b0;
        l2 <= 1'b0;
        integral <= {(14+ISR){1'b0}};
    end
    else begin
        l1 <= s1;
        l2 <= s2;
        if (integral == {1'b0,{14+ISR-1{1'b1}}})  
            integral <= integral + {14+ISR{1'b1}}; 
        else if (integral == {1'b1,{14+ISR-1{1'b0}}}) 
            integral <= integral + {{14+ISR-1{1'b0}},1'b1};
        else if ({e1,e2}==2'b10)
            integral <= integral + {{14+ISR-1{1'b0}},1'b1};
        else if ({e1,e2}==2'b01)  
            integral <= integral + {14+ISR{1'b1}};
    end   
end
endmodule