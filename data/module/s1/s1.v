module s1 (x, y);
        input [31:0] x;
        output [31:0] y;
        assign y[31:22] = x[16:7] ^ x[18:9];
        assign y[21:0] = {x[6:0],x[31:17]} ^ {x[8:0],x[31:19]} ^ x[31:10];
endmodule