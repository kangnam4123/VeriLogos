module PGAOPV_DFCNQD2PO4 (
  D
 ,CP
 ,CDN
 ,Q
 );
input D ;
input CP ;
input CDN ;
output Q ;
reg Q;
always @(posedge CP or negedge CDN)
begin
    if(~CDN)
        Q <= 1'b0;
    else
        Q <= D;
end
endmodule