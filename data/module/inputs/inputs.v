module inputs (validdata, Readtoa, Readtob, iWriteEnable, iAddress, iReadAddress);
output reg Readtoa, Readtob, iWriteEnable ;
output reg [7:0] validdata;
output reg [9:0] iAddress;
output reg [9:0] iReadAddress;
initial
	begin
	#10 validdata = 8'd8; Readtoa = 0; Readtob = 0; iWriteEnable = 1; iAddress =10'd0; iReadAddress =10'd0;
	#500 validdata = 8'd8; Readtoa = 1; Readtob = 0; iWriteEnable = 0; iAddress =10'd0;iReadAddress =10'd0; 
	#1000 validdata = 8'd16; Readtoa = 0; Readtob = 0; iWriteEnable = 1; iAddress =10'd10; iReadAddress =10'd10;
	#1500 validdata = 8'd16; Readtoa = 0; Readtob = 1; iWriteEnable = 0; iAddress =10'd10; iReadAddress =10'd10; 
	#2000 validdata = 8'd32; Readtoa = 0; Readtob = 0; iWriteEnable = 1; iAddress =10'b0000011111;iReadAddress =10'b0000011111;
	#2500 validdata = 8'd32;  Readtoa = 1; Readtob = 0; iWriteEnable = 0;iAddress =10'b0000011111;iReadAddress =10'b0000011111;
	#3000 validdata = 8'd64;  Readtoa = 0; Readtob = 0; iWriteEnable = 1; iAddress =10'b1111111111;  iReadAddress =10'b1111111111;
	#3500 validdata = 8'd64;  Readtoa = 0; Readtob = 1; iWriteEnable = 0; iAddress =10'b1111111111;  iReadAddress =10'b1111111111;
	end
endmodule