module f6_test_2 (input [4:0] in, input enable, output reg [31:0] out);
always @(in or enable)
    if(!enable)
	    out = 32'b00000000000000000000000000000000;
	else begin
	   case (in)
	       5'b00000 : out = 32'b00000000000000000000000000000001;
	       5'b00001 : out = 32'b00000000000000000000000000000010;
	       5'b00010 : out = 32'b00000000000000000000000000000100;
	       5'b00011 : out = 32'b00000000000000000000000000001000;
	       5'b00100 : out = 32'b00000000000000000000000000010000;
	       5'b00101 : out = 32'b00000000000000000000000000100000;
	       5'b00110 : out = 32'b00000000000000000000000001000000;
	       5'b00111 : out = 32'b00000000000000000000000010000000;
	       5'b01000 : out = 32'b00000000000000000000000100000000;
	       5'b01001 : out = 32'b00000000000000000000001000000000;
	       5'b01010 : out = 32'b00000000000000000000010000000000;
	       5'b01011 : out = 32'b00000000000000000000100000000000;
	       5'b01100 : out = 32'b00000000000000000001000000000000;
	       5'b01101 : out = 32'b00000000000000000010000000000000;
	       5'b01110 : out = 32'b00000000000000000100000000000000;
	       5'b01111 : out = 32'b00000000000000001000000000000000;
	       5'b10000 : out = 32'b00000000000000010000000000000000;
	       5'b10001 : out = 32'b00000000000000100000000000000000;
	       5'b10010 : out = 32'b00000000000001000000000000000000;
	       5'b10011 : out = 32'b00000000000010000000000000000000;
	       5'b10100 : out = 32'b00000000000100000000000000000000;
	       5'b10101 : out = 32'b00000000001000000000000000000000;
	       5'b10110 : out = 32'b00000000010000000000000000000000;
	       5'b10111 : out = 32'b00000000100000000000000000000000;
	       5'b11000 : out = 32'b00000001000000000000000000000000;
	       5'b11001 : out = 32'b00000010000000000000000000000000;
	       5'b11010 : out = 32'b00000100000000000000000000000000;
	       5'b11011 : out = 32'b00001000000000000000000000000000;
	       5'b11100 : out = 32'b00010000000000000000000000000000;
	       5'b11101 : out = 32'b00100000000000000000000000000000;
	       5'b11110 : out = 32'b01000000000000000000000000000000;
	       5'b11111 : out = 32'b10000000000000000000000000000000;
	    endcase
	end
endmodule