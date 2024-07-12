module output_arbiter #(
parameter SIZE = 10,
parameter LOOP = 2,
parameter DEPTH = 5
)(
input clk,
input read,
input write,
input [7:0] dataIn,
output wire [7:0] dataOut,
output reg ramFull,
output reg dataAvailable
);
reg [7:0] nodeNum = 0;
reg [7:0] largestVal = 0;
reg [$clog2(SIZE*LOOP - 1'b1):0] outputCnt = 0;
assign dataOut = nodeNum;
always@(posedge clk) begin
	if (write) begin
		outputCnt <= outputCnt + 1'b1;
		if(outputCnt == SIZE*LOOP - 1'b1) begin
			outputCnt <= 0;
			dataAvailable <= 1;
			ramFull <= 1;
		end
		if(dataIn > largestVal) begin
			nodeNum <= outputCnt;
			largestVal <= dataIn;
		end
	end
	if(read) begin
		dataAvailable <= 0;
		ramFull <= 0;	
		largestVal <= 0;
	end
end
endmodule