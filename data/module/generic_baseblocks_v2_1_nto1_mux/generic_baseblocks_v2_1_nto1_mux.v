module generic_baseblocks_v2_1_nto1_mux #
  (
   parameter integer C_RATIO         =  1,  
   parameter integer C_SEL_WIDTH     =  1,  
   parameter integer C_DATAOUT_WIDTH =  1,  
   parameter integer C_ONEHOT        =  0   
   )
  (
   input  wire [C_RATIO-1:0]                 SEL_ONEHOT,  
   input  wire [C_SEL_WIDTH-1:0]             SEL,         
   input  wire [C_RATIO*C_DATAOUT_WIDTH-1:0] IN,          
   output wire [C_DATAOUT_WIDTH-1:0]         OUT          
   );
  wire [C_DATAOUT_WIDTH*C_RATIO-1:0] carry;
  genvar i;
  generate
    if (C_ONEHOT == 0) begin : gen_encoded
      assign carry[C_DATAOUT_WIDTH-1:0] = {C_DATAOUT_WIDTH{(SEL==0)?1'b1:1'b0}} & IN[C_DATAOUT_WIDTH-1:0];
      for (i=1;i<C_RATIO;i=i+1) begin : gen_carrychain_enc
        assign carry[(i+1)*C_DATAOUT_WIDTH-1:i*C_DATAOUT_WIDTH] = 
               carry[i*C_DATAOUT_WIDTH-1:(i-1)*C_DATAOUT_WIDTH] |
               {C_DATAOUT_WIDTH{(SEL==i)?1'b1:1'b0}} & IN[(i+1)*C_DATAOUT_WIDTH-1:i*C_DATAOUT_WIDTH];
      end
    end else begin : gen_onehot
      assign carry[C_DATAOUT_WIDTH-1:0] = {C_DATAOUT_WIDTH{SEL_ONEHOT[0]}} & IN[C_DATAOUT_WIDTH-1:0];
      for (i=1;i<C_RATIO;i=i+1) begin : gen_carrychain_hot
        assign carry[(i+1)*C_DATAOUT_WIDTH-1:i*C_DATAOUT_WIDTH] = 
               carry[i*C_DATAOUT_WIDTH-1:(i-1)*C_DATAOUT_WIDTH] |
               {C_DATAOUT_WIDTH{SEL_ONEHOT[i]}} & IN[(i+1)*C_DATAOUT_WIDTH-1:i*C_DATAOUT_WIDTH];
      end
    end
  endgenerate
  assign OUT = carry[C_DATAOUT_WIDTH*C_RATIO-1:
                     C_DATAOUT_WIDTH*(C_RATIO-1)];
endmodule