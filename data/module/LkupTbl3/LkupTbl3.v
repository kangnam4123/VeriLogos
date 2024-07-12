module LkupTbl3 
  (
  cosine,
  sine,
  CLK,
  ARST,
  cntr
  );
output reg [15:0]        sine    ;
output reg [15:0]        cosine  ;
input                    CLK     ;
input                    ARST    ;
input      [4:0]         cntr    ;
always @ (posedge CLK or posedge ARST)
if (ARST)
 begin
  sine   = 'b0000000000000000; 
  cosine = 'b0000000000000000; 
 end
else
 begin
 case (cntr)
  0: 
    begin
      sine   = 'b0000000000000000; 
      cosine = 'b0100000000000000; 
    end
  1: 
    begin
      sine   = 'b0011110111010001; 
      cosine = 'b1110111101110000; 
    end
  2: 
    begin
      sine   = 'b1110000000000001; 
      cosine = 'b1100100010010100; 
    end
  3: 
    begin
      sine   = 'b1101001010111111; 
      cosine = 'b0010110101000001; 
    end
  4: 
    begin
      sine   = 'b0011011101101100; 
      cosine = 'b0010000000000000; 
    end
  5: 
    begin
      sine   = 'b0001000010010000; 
      cosine = 'b1100001000101111; 
    end
  6: 
    begin
      sine   = 'b1100000000000000; 
      cosine = 'b0000000000000000; 
    end
  7: 
    begin
      sine   = 'b0001000010010000; 
      cosine = 'b0011110111010001; 
    end
  8: 
    begin
      sine   = 'b0011011101101100; 
      cosine = 'b1110000000000001; 
    end
  9: 
    begin
      sine   = 'b1101001010111111; 
      cosine = 'b1101001010111111; 
    end
  10: 
    begin
      sine   = 'b1110000000000000; 
      cosine = 'b0011011101101100; 
    end
  11: 
    begin
      sine   = 'b0011110111010001; 
      cosine = 'b0001000010010000; 
    end
  12: 
    begin
      sine   = 'b0000000000000000; 
      cosine = 'b1100000000000000; 
    end
  13: 
    begin
      sine   = 'b1100001000101111; 
      cosine = 'b0001000010010000; 
    end
  14: 
    begin
      sine   = 'b0001111111111111; 
      cosine = 'b0011011101101100; 
    end
  15: 
    begin
      sine   = 'b0010110101000001; 
      cosine = 'b1101001010111111; 
    end
  16: 
    begin
      sine   = 'b1100100010010100; 
      cosine = 'b1110000000000000; 
    end
  17: 
    begin
      sine   = 'b1110111101110000; 
      cosine = 'b0011110111010001; 
    end
  18: 
    begin
      sine   = 'b0100000000000000; 
      cosine = 'b0000000000000000; 
    end
  19: 
    begin
      sine   = 'b1110111101110000; 
      cosine = 'b1100001000101111; 
    end
  20: 
    begin
      sine   = 'b1100100010010100; 
      cosine = 'b0001111111111111; 
    end
  21: 
    begin
      sine   = 'b0010110101000001; 
      cosine = 'b0010110101000001; 
    end
  22: 
    begin
      sine   = 'b0010000000000000; 
      cosine = 'b1100100010010100; 
    end
  23: 
    begin
      sine   = 'b1100001000101111; 
      cosine = 'b1110111101110000; 
    end
  default:
    begin
      sine   = 'b0000000000000000; 
      cosine = 'b0000000000000000; 
    end
  endcase
 end
endmodule