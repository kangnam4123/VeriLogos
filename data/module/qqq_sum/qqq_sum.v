module qqq_sum( input[31:0]  A, B,
                output[31:0] R,
                input  Cin );
assign R = A + B + Cin;
endmodule