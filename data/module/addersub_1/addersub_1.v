module addersub_1 (
            opA, opB,
            op, 
            result,
            result_slt );
parameter WIDTH=32;
input [WIDTH-1:0] opA;
input [WIDTH-1:0] opB;
input [3-1:0] op;
output [WIDTH-1:0] result;
output result_slt;
wire carry_out;
wire [WIDTH:0] sum;
wire is_slt;
wire signext;
wire addsub;
assign is_slt=op[2];
assign signext=op[1];
assign addsub=op[0];
assign result=sum[WIDTH-1:0];
assign result_slt=sum[WIDTH];
wire [WIDTH-1:0] oA;
wire [WIDTH-1:0] oB;
wire [WIDTH-1:0] o_B;
assign oA = {signext&opA[WIDTH-1],opA};
assign oB = {signext&opB[WIDTH-1],opB};
assign sum = (addsub == 1'b1) ? oA + oB : oA - oB;
assign carry_out=sum[WIDTH];
endmodule