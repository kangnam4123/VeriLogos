module GP_PGA(input wire VIN_P, input wire VIN_N, input wire VIN_SEL, output reg VOUT);
	parameter GAIN = 1;
	parameter INPUT_MODE = "SINGLE";
	initial VOUT = 0;
endmodule