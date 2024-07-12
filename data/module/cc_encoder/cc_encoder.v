module cc_encoder (
        clk         ,   
        ce          ,   
        nrst        ,   
        cc_start    ,   
        rate        ,   
        vin         ,   
        din         ,   
        vout        ,   
        dout        ,   
        mask            
        ) ;
input               clk ;
input               ce ;
input               nrst ;
input               cc_start ;  
input       [1:0]   rate ;
input               vin ;       
input       [3:0]   din ;       
output              vout ;      
output      [7:0]   dout ;
output reg  [7:0]   mask ;
wire    [3:0]   u ;
wire    [7:0]   v ;
reg             s0 ;
reg             s1 ;
reg             s2 ;
reg             s3 ;
reg             s4 ;
reg             s5 ;
wire            s0_next ;
wire            s1_next ;
wire            s2_next ;
wire            s3_next ;
wire            s4_next ;
wire            s5_next ;
wire    [3:0]   A ;
wire    [3:0]   B ;
reg     [1:0]   cnt ;
assign vout = vin ;
assign dout = v ;
assign A[3] = u[3] ^ s1 ^ s2 ^ s4 ^ s5 ;
assign B[3] = u[3] ^ s0 ^ s1 ^ s2 ^ s5 ;
assign A[2] = (u[2] ^ s0 ^ s1 ^ s3 ^ s4) ;
assign B[2] = (u[2] ^ u[3] ^ s0 ^ s1 ^ s4) ;
assign A[1] = (u[1] ^ u[3] ^ s0 ^ s2 ^ s3) ;
assign B[1] = (u[1] ^ u[2] ^ u[3] ^ s0 ^ s3) ;
assign A[0] = (u[0] ^ u[2] ^ u[3] ^ s1 ^ s2) ;
assign B[0] = (u[0] ^ u[1] ^ u[2] ^ u[3] ^ s2) ;
assign u = din ;
assign v = {A[3], B[3], A[2], B[2], A[1], B[1], A[0], B[0]} ;
assign s0_next = u[0] ;
assign s1_next = u[1] ;
assign s2_next = u[2] ;
assign s3_next = u[3] ;
assign s4_next = s0 ;
assign s5_next = s1 ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
  begin
    s0 <= 1'b0 ;
    s1 <= 1'b0 ;
    s2 <= 1'b0 ;
    s3 <= 1'b0 ;
    s4 <= 1'b0 ;
    s5 <= 1'b0 ;
  end
  else if (ce)
  begin
    if (cc_start)
    begin
      s0 <= 1'b0 ;
      s1 <= 1'b0 ;
      s2 <= 1'b0 ;
      s3 <= 1'b0 ;
      s4 <= 1'b0 ;
      s5 <= 1'b0 ;
    end
    else if (vin)
    begin
      s0 <= s0_next ;
      s1 <= s1_next ;
      s2 <= s2_next ;
      s3 <= s3_next ;
      s4 <= s4_next ;
      s5 <= s5_next ;
    end
  end
always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (ce)
  begin
    if (cc_start)
      cnt <= 0 ;
    else if (vin)
    begin
      if (cnt == 2)
        cnt <= 0 ;
      else
        cnt <= cnt +1 ;
    end
  end
always @*
begin
  mask = 8'd0 ;
  if (rate == 0)
    mask = 8'b1111_1111 ;
  else if (rate == 1)
    mask = 8'b1110_1110 ;
  else
  begin
    case(cnt)
      0: mask = 8'b1110_0111 ;
      1: mask = 8'b1001_1110 ; 
      2: mask = 8'b0111_1001 ;
      default: mask = 8'b1110_0111 ;
    endcase
  end
end
endmodule