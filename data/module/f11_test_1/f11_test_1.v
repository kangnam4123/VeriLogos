module f11_test_1(input in, output reg [1:0] out);
    always @(in)
    begin
        out = in;
        out = out + in;
    end
endmodule