module MUX4X1 #(parameter SIZE=32) 
(
	input wire[SIZE-1:0] iInput0,
	input wire[SIZE-1:0] iInput1,
	input wire[SIZE-1:0] iInput2,
	input wire[SIZE-1:0] iInput3,
	input wire[1:0] iSelect,
	output reg[SIZE-1:0] oOutput	
);
always @(*) begin
case (iSelect)
2'd0: oOutput=iInput0;
2'd1: oOutput=iInput1;
2'd2: oOutput=iInput2;
2'd3: oOutput=iInput3;
endcase
end
endmodule