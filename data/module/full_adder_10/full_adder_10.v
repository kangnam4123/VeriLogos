module full_adder_10 (cin,x,y,s,cout);
input cin;
input x;
input y;
output s;
output cout;
assign s = x^y^cin;
assign cout = (x&y) | (x & cin) | (y&cin);
endmodule