module AXI_SP32B1024(
	input			CLK,
	input			RST,
	input         	axi_awvalid,
	output        	axi_awready,
	input  [32-1:0] axi_awaddr,
	input  [3-1:0]  axi_awprot,
	input         	axi_wvalid,
	output        	axi_wready,
	input  [32-1:0] axi_wdata,
	input  [4-1:0]  axi_wstrb,
	output        	axi_bvalid,
	input         	axi_bready,
	input         	axi_arvalid,
	output        	axi_arready,
	input  [32-1:0] axi_araddr,
	input  [3-1:0]  axi_arprot,
	output        	axi_rvalid,
	input         	axi_rready,
	output [32-1:0] axi_rdata,
	input [31:0] Q,
	output reg CEN,
	output reg WEN,
	output reg [9:0] A,
	output [31:0] D
	);
	assign axi_awready = 1'b1;
	assign axi_arready = 1'b1;
	assign axi_wready = 1'b1;
	reg [31:0] DP;
	assign axi_rdata = Q;
	always @(negedge CLK) begin
		if (RST==1'b0) begin
			A <= {10{1'b0}};
			DP <= {32{1'b0}};
		end else begin 
			if(axi_awvalid == 1'b1) begin
				A <= axi_awaddr[9:0];
			end else if(axi_arvalid == 1'b1) begin
				A <= axi_araddr[9:0];
			end
			if(axi_wvalid == 1'b1) begin
				DP <= axi_wdata;
			end
 		end
	end
	reg reading1, reading2;
	assign axi_rvalid = reading2;
	always @(posedge CLK) begin
		if (RST==1'b0) begin
			reading1 <= 1'b0;
			reading2 <= 1'b0;
		end else begin 
			if(axi_rready == 1'b1 && reading1 == 1'b1 && reading2 == 1'b1) begin
				reading1 <= 1'b0;
			end else if(axi_arvalid == 1'b1) begin
				reading1 <= 1'b1;
			end
			if(axi_rready == 1'b1 && reading1 == 1'b1 && reading2 == 1'b1) begin
				reading2 <= 1'b0;
			end else if(reading1 == 1'b1) begin
				reading2 <= 1'b1;
			end
		end
	end
	reg writting1, writting2, writting3;
	assign axi_bvalid = writting3;
	always @(posedge CLK) begin
		if (RST==1'b0) begin
			writting1 <= 1'b0;
			writting2 <= 1'b0;
			writting3 <= 1'b0;
		end else begin 
			if(axi_bready == 1'b1 && writting1 == 1'b1 && writting2 == 1'b1 && writting3 == 1'b1) begin
				writting3 <= 1'b0;
			end else if(writting2 == 1'b1) begin
				writting3 <= 1'b1;
			end else begin
				writting3 <= writting3;
			end
			if(axi_bready == 1'b1 && writting1 == 1'b1 && writting2 == 1'b1 && writting3 == 1'b1) begin
				writting1 <= 1'b0;
			end else if(axi_awvalid == 1'b1) begin
				writting1 <= 1'b1;
			end else begin
				writting1 <= writting1;
			end
			if(axi_bready == 1'b1 && writting1 == 1'b1 && writting2 == 1'b1 && writting3 == 1'b1) begin
				writting2 <= 1'b0;
			end else if(axi_wvalid == 1'b1) begin
				writting2 <= 1'b1;
			end else begin
				writting2 <= writting2;
			end
		end
	end
	always @(negedge CLK) begin
		if (RST==1'b0) begin
			CEN <= 1'b1;
			WEN <= 1'b1;
		end else begin 
			CEN <= ~(reading1 | writting1);
			WEN <= ~writting2;
		end
	end
	assign D[7:0]   = axi_wstrb[0]?DP[7:0]  :Q[7:0];
	assign D[15:8]  = axi_wstrb[1]?DP[15:8] :Q[15:8];
	assign D[23:16] = axi_wstrb[2]?DP[23:16]:Q[23:16];
	assign D[31:24] = axi_wstrb[3]?DP[31:24]:Q[31:24];
endmodule