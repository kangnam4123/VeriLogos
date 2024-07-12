module pufInputNetwork	#(parameter Width = 32)
								(input wire [Width-1:0] dataIn,
								output wire [Width-1:0] dataOut);
	parameter N = Width;
	wire [Width:1] os_dataIn;
	wire [Width:1] os_dataOut;
	assign os_dataIn[Width:1] = dataIn[Width-1:0];
	assign dataOut[Width-1:0] = os_dataOut[Width:1];
	assign os_dataOut[(Width+2)/2]  = os_dataIn[1];
	genvar i;
	generate
		for (i = 2; i < N; i=i+1) begin:m
			if(i%2 != 0) begin
				assign os_dataOut[(i+1)/2] = os_dataIn[i] + os_dataIn[i+1];
			end
			else begin
				assign os_dataOut[(N+i+2)/2] = os_dataIn[i] + os_dataIn[i+1];
			end
		end
	endgenerate
endmodule