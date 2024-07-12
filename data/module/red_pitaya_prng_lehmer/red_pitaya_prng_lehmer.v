module red_pitaya_prng_lehmer #(
    parameter     A = 48271,      
    parameter     B = 323485697,
    parameter     SEED = 901448241,
    parameter     STATEBITS = 31,
    parameter     OUTBITS   = 14
)
(
    input clk_i,
    input reset_i  ,
    output signed [OUTBITS-1:0] signal_o
);
reg [STATEBITS-1:0] xn;
wire [STATEBITS-1:0] xn_wire;
reg [STATEBITS-1:0] b;
reg [16-1:0] a;
always @(posedge clk_i)
if (reset_i == 1'b0) begin
   a <= A;
   b <= B;   
   xn <= SEED ; 
end else begin
   xn <= ((&xn_wire)==1'b1) ? {STATEBITS{1'b0}} : xn_wire;
end
assign xn_wire = a * xn + b;
assign signal_o = xn[STATEBITS-1:STATEBITS-OUTBITS];
endmodule