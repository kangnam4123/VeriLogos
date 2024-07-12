module memory2_1(reset,address,in,out,write,clk, testWire); 
input [7:0] in;
input clk,write,reset;
input [14:0] address;
output  reg [7:0] out;
output wire [7:0] testWire;
reg [7:0] mem [0:255];
integer i;
assign testWire = mem[7];
always @(negedge clk)
begin
out = mem[address];	
if(reset== 1'b0)
begin
for(i=0;i<256;i=i+1)
mem [i] = 0;
mem[0] = 8'b10010010;
mem[1] = 8'b01100100; 
mem[2] = 8'b00010110; 
mem[3] = 8'b01110111; 
mem[4] = 8'b00101111; 
mem[5] = 8'b00000010;
mem[26] =8'b11000001;
mem[31] = 8'b01001000;
mem[33] = 8'b11100001;
end
if(write ==1'b0)
begin
	mem[address] <= in;
end
end
endmodule