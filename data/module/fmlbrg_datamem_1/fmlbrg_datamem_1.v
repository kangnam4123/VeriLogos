module fmlbrg_datamem_1 #(
	parameter depth = 8
) (
	input sys_clk,
	input [depth-1:0] addr,
	input [1:0] we,
	input [15:0] dat_i,
	output [15:0] dat_o
);
reg [7:0] ram0[0:(1 << depth)-1];
reg [7:0] ram1[0:(1 << depth)-1];
wire [7:0] ram0di;
wire [7:0] ram1di;
reg [7:0] ram0do;
reg [7:0] ram1do;
always @(posedge sys_clk) begin
	if(we[1]) begin
		ram1[addr] <= ram1di;
		ram1do  <= ram1di;
	end else
		ram1do <= ram1[addr];
end
always @(posedge sys_clk) begin
	if(we[0]) begin
		ram0[addr] <= ram0di;
		ram0do <= ram0di;
	end else
		ram0do <= ram0[addr];
end
assign ram0di = dat_i[7:0];
assign ram1di = dat_i[15:8];
assign dat_o = {ram1do, ram0do};
endmodule