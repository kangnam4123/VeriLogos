module jt12_dac #(parameter width=12)
(
	input	clk,
    input	rst,
    input	signed	[width-1:0] din,
    output	dout
);
localparam acc_w = width+1;
reg [width-1:0] nosign;
reg [acc_w-1:0] acc;
wire [acc_w-2:0] err = acc[acc_w-2:0];
assign dout = acc[acc_w-1];
always @(posedge clk) 
if( rst ) begin
	acc <= {(acc_w){1'b0}};
	nosign <= {width{1'b0}};
end
else begin
	nosign <= { ~din[width-1], din[width-2:0] };
	acc <= nosign + err;
end
endmodule