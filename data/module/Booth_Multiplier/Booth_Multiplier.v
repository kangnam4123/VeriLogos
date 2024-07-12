module Booth_Multiplier #(
    parameter pN = 4                
)(
    input   Rst,                    
    input   Clk,                    
    input   Ld,                     
    input   [(2**pN - 1):0] M,      
    input   [(2**pN - 1):0] R,      
    output  reg Valid,              
    output  reg [(2**(pN+1) - 1):0] P   
);
reg     [2**pN:0] A;      
reg     [   pN:0] Cntr;   
reg     [2**pN:0] S;      
reg     [(2**(pN+1) + 1):0] Prod;   
always @(posedge Clk)
begin
    if(Rst)
        Cntr <= #1 0;
    else if(Ld)
        Cntr <= #1 2**pN;
    else if(|Cntr)
        Cntr <= #1 (Cntr - 1);
end
always @(posedge Clk)
begin
    if(Rst)
        A <= #1 0;
    else if(Ld)
        A <= #1 {M[2**pN - 1], M};  
end
always @(*)
begin
    case(Prod[1:0])
        2'b01   : S <= Prod[(2**(pN+1) + 1):(2**pN + 1)] + A;
        2'b10   : S <= Prod[(2**(pN+1) + 1):(2**pN + 1)] - A;
        default : S <= Prod[(2**(pN+1) + 1):(2**pN + 1)];
    endcase
end
always @(posedge Clk)
begin
    if(Rst)
        Prod <= #1 0;
    else if(Ld)
        Prod <= #1 {R, 1'b0};
    else if(|Cntr)
        Prod <= #1 {S[2**pN], S, Prod[2**pN:1]};    
end
always @(posedge Clk)
begin
    if(Rst)
        P <= #1 0;
    else if(Cntr == 1)
        P <= #1 {S[2**pN], S, Prod[2**pN:2]};
end
always @(posedge Clk)
begin
    if(Rst)
        Valid <= #1 0;
    else
        Valid <= #1 (Cntr == 1);
end
endmodule