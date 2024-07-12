module mpu_if( 
I_RSTn, 
I_E, 
I_DI, 
I_RS, 
I_RWn, 
I_CSn, 
O_Nht, 
O_Nhd, 
O_Nhsp, 
O_Nhsw, 
O_Nvt, 
O_Nadj, 
O_Nvd, 
O_Nvsp, 
O_Nvsw, 
O_Nr, 
O_Msa, 
O_DScue, 
O_CScue, 
O_VMode, 
O_IntSync
); 
input I_RSTn; 
input  I_E; 
input  [7:0]I_DI; 
input  I_RS; 
input  I_RWn; 
input  I_CSn; 
output [7:0]O_Nht; 
output [7:0]O_Nhd; 
output [7:0]O_Nhsp; 
output [3:0]O_Nhsw; 
output [6:0]O_Nvt; 
output [4:0]O_Nadj; 
output [6:0]O_Nvd; 
output [6:0]O_Nvsp; 
output [3:0]O_Nvsw; 
output [4:0]O_Nr; 
output [13:0]O_Msa; 
output [1:0] O_DScue; 
output [1:0] O_CScue; 
output O_VMode; 
output O_IntSync; 
reg    [4:0]R_ADR; 
reg    [7:0]R_Nht; 
reg    [7:0]R_Nhd; 
reg    [7:0]R_Nhsp; 
reg    [7:0]R_Nsw; 
reg    [6:0]R_Nvt; 
reg    [4:0]R_Nadj; 
reg    [6:0]R_Nvd; 
reg    [6:0]R_Nvsp; 
reg    [7:0]R_Intr; 
reg    [4:0]R_Nr; 
reg    [5:0]R_Msah; 
reg    [7:0]R_Msal; 
assign O_Nht  = R_Nht; 
assign O_Nhd  = R_Nhd; 
assign O_Nhsp = R_Nhsp; 
assign O_Nhsw = R_Nsw[3:0]; 
assign O_Nvt  = R_Nvt; 
assign O_Nadj = R_Nadj; 
assign O_Nvd  = R_Nvd; 
assign O_Nvsp = R_Nvsp; 
assign O_Nvsw = R_Nsw[7:4]; 
assign O_Nr   = R_Nr; 
assign O_Msa  = {R_Msah,R_Msal}; 
assign O_VMode   =  R_Intr[1]; 
assign O_IntSync =  R_Intr[0]; 
assign O_DScue   = R_Intr[5:4]; 
assign O_CScue   = R_Intr[7:6]; 
always@(negedge I_RSTn or negedge I_E) 
begin 
  if(~I_RSTn) begin 
    R_Nht  <= 8'h3F;     
    R_Nhd  <= 8'h28;     
    R_Nhsp <= 8'h33;     
    R_Nsw  <= 8'h24;     
    R_Nvt  <= 7'h1E;     
    R_Nadj <= 5'h02;     
    R_Nvd  <= 7'h19;     
    R_Nvsp <= 7'h1B; 
    R_Intr <= 8'h91; 
    R_Nr   <= 5'h09; 
    R_Msah <= 6'h28;     
    R_Msal <= 8'h00;     
  end else 
  if(~I_CSn)begin 
    if(~I_RWn)begin 
      if(~I_RS)begin       
        R_ADR <= I_DI[4:0]; 
      end else begin 
        case(R_ADR) 
          5'h0 : R_Nht  <= I_DI ; 
          5'h1 : R_Nhd  <= I_DI ; 
          5'h2 : R_Nhsp <= I_DI ; 
          5'h3 : R_Nsw  <= I_DI ; 
          5'h4 : R_Nvt  <= I_DI[6:0] ; 
          4'h5 : R_Nadj <= I_DI[4:0] ; 
          5'h6 : R_Nvd  <= I_DI[6:0] ; 
          5'h7 : R_Nvsp <= I_DI[6:0] ; 
          5'h8 : R_Intr <= I_DI[7:0] ; 
          5'h9 : R_Nr   <= I_DI[4:0] ; 
          5'hC : R_Msah <= I_DI[5:0] ; 
          5'hD : R_Msal <= I_DI ; 
          default:; 
        endcase 
      end 
    end 
  end 
end 
endmodule