module edgedet(clk, rstn, datain, edgeseen);
	input clk;
	input rstn;
	input datain;
	output reg edgeseen;
	reg lastdata;
	reg [3:0] count;
	always @(posedge clk or negedge rstn) begin
		if(rstn == 0) begin
			edgeseen <= 0;
			lastdata <= 0; 
			count  <= 4'b0000; 
		end else begin
			edgeseen <= 0;
			if(count < 15) begin 
			    lastdata <= datain;
				count <= count + 1'b1;
			end
			if(count == 13) begin
				edgeseen <= 1; 
			end
			if((count == 15)  && (lastdata ^ datain)) begin
				edgeseen <= 1; 
				lastdata <= datain; 
			end	
		end
	end
endmodule