module f3_test_3(a, b, c);
input b, c;
output reg a;
always @(b or c) begin
a = b;
a = c;
end
endmodule