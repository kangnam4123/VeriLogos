module Booth_Multiplier_1xA #(
    parameter N = 16            
)(
    input   Rst,                
    input   Clk,                
    input   Ld,                 
    input   [(N - 1):0] M,      
    input   [(N - 1):0] R,      
    output  reg Valid,          
    output  reg [(2*N - 1):0] P 
);
reg     [4:0] Cntr;             
reg     [1:0] Booth;            
reg     Guard;                  
reg     [N:0] A;                
reg     [N:0] B;                
reg     Ci;                     
reg     [N:0] S;                
wire    [N:0] Hi;               
reg     [2*N:0] Prod;           
always @(posedge Clk)
begin
    if(Rst)
        Cntr <= #1 0;
    else if(Ld)
        Cntr <= #1 N;
    else if(|Cntr)
        Cntr <= #1 (Cntr - 1);
end
always @(posedge Clk)
begin
    if(Rst)
        A <= #1 0;
    else if(Ld)
        A <= #1 {M[N - 1], M};  
end
always @(*) Booth <= {Prod[0], Guard};  
assign Hi = Prod[2*N:N];                
always @(*)
begin
    case(Booth)
        2'b01   : {Ci, B} <= {1'b0,  A};
        2'b10   : {Ci, B} <= {1'b1, ~A};
        default : {Ci, B} <= 0;
    endcase
end
always @(*) S <= Hi + B + Ci;
always @(posedge Clk)
begin
    if(Rst)
        Prod <= #1 0;
    else if(Ld)
        Prod <= #1 R;
    else if(|Cntr)  
        Prod <= #1 {S[N], S, Prod[(N - 1):1]};
end
always @(posedge Clk)
begin
    if(Rst)
        Guard <= #1 0;
    else if(Ld)
        Guard <= #1 0;
    else if(|Cntr)
        Guard <= #1 Prod[0];
end
always @(posedge Clk)
begin
    if(Rst)
        P <= #1 0;
    else if(Cntr == 1)
        P <= #1 {S, Prod[(N - 1):1]};
end
always @(posedge Clk)
begin
    if(Rst)
        Valid <= #1 0;
    else
        Valid <= #1 (Cntr == 1);
end
endmodule