module Booth_Multiplier_4x #(
    parameter N = 16                
)(
    input   Rst,                    
    input   Clk,                    
    input   Ld,                     
    input   [(N - 1):0] M,          
    input   [(N - 1):0] R,          
    output  reg Valid,              
    output  reg [((2*N) - 1):0] P   
);
localparam pNumCycles = ((N + 1)/4);    
reg     [4:0] Cntr;                     
reg     [4:0] Booth;                    
reg     Guard;                          
reg     [(N + 3):0] A;                  
reg     [(N + 3):0] S;                  
wire    [(N + 3):0] Hi;                 
reg     [((2*N) + 3):0] Prod;           
always @(posedge Clk)
begin
    if(Rst)
        Cntr <= #1 0;
    else if(Ld)
        Cntr <= #1 pNumCycles;
    else if(|Cntr)
        Cntr <= #1 (Cntr - 1);
end
always @(posedge Clk)
begin
    if(Rst)
        A <= #1 0;
    else if(Ld)
        A <= #1 {{4{M[(N - 1)]}}, M};
end
always @(*) Booth <= {Prod[3:0], Guard};    
assign Hi = Prod[((2*N) + 3):N];            
always @(*)
begin
    case(Booth)
        5'b00000 : S <= Hi;                         
        5'b00001 : S <= Hi +  A;                    
        5'b00010 : S <= Hi +  A;                    
        5'b00011 : S <= Hi + {A, 1'b0};             
        5'b00100 : S <= Hi + {A, 1'b0};             
        5'b00101 : S <= Hi + {A, 1'b0} +  A;        
        5'b00110 : S <= Hi + {A, 1'b0} +  A;        
        5'b00111 : S <= Hi + {A, 2'b0};             
        5'b01000 : S <= Hi + {A, 2'b0};             
        5'b01001 : S <= Hi + {A, 2'b0} +  A;        
        5'b01010 : S <= Hi + {A, 2'b0} +  A;        
        5'b01011 : S <= Hi + {A, 2'b0} + {A, 1'b0}; 
        5'b01100 : S <= Hi + {A, 2'b0} + {A, 1'b0}; 
        5'b01101 : S <= Hi + {A, 3'b0} -  A;        
        5'b01110 : S <= Hi + {A, 3'b0} -  A;        
        5'b01111 : S <= Hi + {A, 3'b0};             
        5'b10000 : S <= Hi - {A, 3'b0};             
        5'b10001 : S <= Hi - {A, 3'b0} +  A;        
        5'b10010 : S <= Hi - {A, 3'b0} +  A;        
        5'b10011 : S <= Hi - {A, 2'b0} - {A, 1'b0}; 
        5'b10100 : S <= Hi - {A, 2'b0} - {A, 1'b0}; 
        5'b10101 : S <= Hi - {A, 2'b0} -  A;        
        5'b10110 : S <= Hi - {A, 2'b0} -  A;        
        5'b10111 : S <= Hi - {A, 2'b0};             
        5'b11000 : S <= Hi - {A, 2'b0};             
        5'b11001 : S <= Hi - {A, 1'b0} -  A;        
        5'b11010 : S <= Hi - {A, 1'b0} -  A;        
        5'b11011 : S <= Hi - {A, 1'b0};             
        5'b11100 : S <= Hi - {A, 1'b0};             
        5'b11101 : S <= Hi -  A;                    
        5'b11110 : S <= Hi -  A;                    
        5'b11111 : S <= Hi;                         
    endcase
end
always @(posedge Clk)
begin
    if(Rst)
        Prod <= #1 0;
    else if(Ld)
        Prod <= #1 R;
    else if(|Cntr)  
        Prod <= #1 {{4{S[(N + 3)]}}, S, Prod[(N - 1):4]};
end
always @(posedge Clk)
begin
    if(Rst)
        Guard <= #1 0;
    else if(Ld)
        Guard <= #1 0;
    else if(|Cntr)
        Guard <= #1 Prod[3];
end
always @(posedge Clk)
begin
    if(Rst)
        P <= #1 0;
    else if(Cntr == 1)
        P <= #1 {S, Prod[(N - 1):4]};
end
always @(posedge Clk)
begin
    if(Rst)
        Valid <= #1 0;
    else
        Valid <= #1 (Cntr == 1);
end
endmodule