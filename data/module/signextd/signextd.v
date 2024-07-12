module signextd(datain, dataout);
input [15:0] datain;
output [31:0] dataout;
reg [31:0] dataout;
integer i;
always @ (datain)
begin
  dataout = $signed(datain);
end
endmodule