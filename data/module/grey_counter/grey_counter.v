module grey_counter(input clk, output reg [7:0] count);
	reg [7:0] n;	
	always @(posedge clk) begin
		if (0 == n)
			count <= 8'b00000000;
		else if (1 == n)
			count[0] <= 1;
		else if (2 == n)
			count[1] <= 1;
		else if (4 == n)
			count[2] <= 1;
		else if (8 == n)
			count[3] <= 1;
		else if (16 == n)
			count[4] <= 1;
		else if (32 == n)
			count[5] <= 1;
		else if (64 == n)
			count[6] <= 1;
		else if (128 == n)
			count[7] <= 1;
		else if (0 == (n - 1) % 2)
			count[0] <= ~count[0];
		else if (0 == (n - 2) % 4)
			count[1] <= ~count[1];
		else if (0 == (n - 4) % 8)
			count[2] <= ~count[2];
		else if (0 == (n - 8) % 16)
			count[3] <= ~count[3];
		else if (0 == (n - 16) % 32)
			count[4] <= ~count[4];
		else if (0 == (n - 32) % 64)
			count[5] <= ~count[5];
		else if (0 == (n - 64) % 128)
			count[6] <= ~count[6];
		else if (0 == (n - 128) % 256)
			count[7] <= ~count[7];
		else begin
			count <= 8'b00000000;  
		end
		if (n >= 255)
			n <= 0;
		else if (n >= 0)
			n <= n + 1;
		else
			n <= 0;		
	end
endmodule