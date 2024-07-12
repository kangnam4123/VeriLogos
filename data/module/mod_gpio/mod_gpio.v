module mod_gpio(rst, clk, ie, de, iaddr, daddr, drw, din, iout, dout, gpio);
        input rst;
        input clk;
        input ie,de;
        input [31:0] iaddr, daddr;
        input [1:0] drw;
        input [31:0] din;
        output [31:0] iout, dout;
	inout [15:0] gpio;
        wire [31:0] idata, ddata;
        assign iout = idata;
        assign dout = ddata;
	reg [15:0] direction = 16'h0000;
	reg [7:0] gpio_a, gpio_b;
	assign idata = 32'h00000000;
	assign ddata = (daddr == 32'h00000000) ? {16'h0000, direction} : 
		       (daddr == 32'h00000004) ? {24'h000000, gpio[7:0]} :  
		       (daddr == 32'h00000008) ? {24'h000000, gpio[15:8]} : 0;
	assign gpio[0]  = (direction[0])  ? gpio_a[0] : 1'bz;
	assign gpio[1]  = (direction[1])  ? gpio_a[1] : 1'bz;
	assign gpio[2]  = (direction[2])  ? gpio_a[2] : 1'bz;
	assign gpio[3]  = (direction[3])  ? gpio_a[3] : 1'bz;
	assign gpio[4]  = (direction[4])  ? gpio_a[4] : 1'bz;
	assign gpio[5]  = (direction[5])  ? gpio_a[5] : 1'bz;
	assign gpio[6]  = (direction[6])  ? gpio_a[6] : 1'bz;
	assign gpio[7]  = (direction[7])  ? gpio_a[7] : 1'bz;
	assign gpio[8]  = (direction[8])  ? gpio_b[0] : 1'bz;
	assign gpio[9]  = (direction[9])  ? gpio_b[1] : 1'bz;
	assign gpio[10] = (direction[10]) ? gpio_b[2] : 1'bz;
	assign gpio[11] = (direction[11]) ? gpio_b[3] : 1'bz;
	assign gpio[12] = (direction[12]) ? gpio_b[4] : 1'bz;
	assign gpio[13] = (direction[13]) ? gpio_b[5] : 1'bz;
	assign gpio[14] = (direction[14]) ? gpio_b[6] : 1'bz;
	assign gpio[15] = (direction[15]) ? gpio_b[7] : 1'bz;
	always @(negedge clk) begin
		if (drw[0] && de && !rst) begin
			if (daddr == 32'h00000000)
				direction <= din[15:0];
			else if (daddr == 32'h00000004)
				gpio_a <= din[7:0];
			else if (daddr == 32'h00000008)
				gpio_b <= din[7:0];
		end else if (rst) begin
			gpio_a <= 8'h00;
			gpio_b <= 8'h00;
			direction <= 16'h0000;
		end
	end
endmodule