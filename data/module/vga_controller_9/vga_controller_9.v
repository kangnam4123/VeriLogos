module vga_controller_9 (clk, rst, hs, vs, blank, hcount, vcount);
  input             clk, rst;
  output 	        hs, vs;
  output reg 		  blank;
  output reg [10:0] hcount, vcount;
  reg        [10:0] hcounter, vcounter;
  parameter H_FRONTPORCH = 16;
  parameter H_BACKPORCH  = 48;
  parameter H_PULSEWIDTH = 96;
  parameter H_PERIOD     = 800;
  parameter V_FRONTPORCH = 10;
  parameter V_BACKPORCH  = 29;
  parameter V_PULSEWIDTH = 2;
  parameter V_PERIOD     = 521;
  assign hs = (hcounter < H_PULSEWIDTH) ? 0 : 1;
  assign vs = (vcounter < V_PULSEWIDTH) ? 0 : 1;
  always @(negedge clk) begin
	if (rst) begin
		hcount   = 0;
		vcount   = 0;
		hcounter = 0;
		vcounter = 0;
		blank    = 1;
	end
    blank = (hcounter >= H_PULSEWIDTH + H_BACKPORCH && 
             hcounter <  H_PERIOD - H_FRONTPORCH &&
             vcounter >= V_PULSEWIDTH + V_BACKPORCH &&
             vcounter <  V_PERIOD - V_FRONTPORCH)
             ? 0 : 1;
    hcounter = hcounter + 1;
    if (hcounter == H_PERIOD) begin
      hcounter = 0;
      vcounter = (vcounter == V_PERIOD) ? 0 : vcounter + 1;
    end
    hcount = ((hcounter >= H_PULSEWIDTH + H_BACKPORCH) && 
              (hcounter <  H_PERIOD - H_FRONTPORCH))
              ? (hcounter - H_PULSEWIDTH) - H_BACKPORCH : 0;
    vcount = ((vcounter >= V_PULSEWIDTH + V_BACKPORCH) &&
              (vcounter <  V_PERIOD - V_FRONTPORCH))
              ? (vcounter - V_PULSEWIDTH) - V_BACKPORCH : 0;
  end
endmodule