module Reg_1(input clk, upZ, output signed[31:0] valZ, valX, valY,
           input[3:0] idxZ, idxX, idxY, input signed[31:0] nextZ, nextP);
    reg[31:0] store[0:14];
    integer k;
    initial for (k = 0; k < 15; k = k + 1) store[k] = 0;
    assign valX = &idxX ? nextP : store[idxX];
    assign valY = &idxY ? nextP : store[idxY];
    assign valZ = &idxZ ? nextP : store[idxZ];
    always @(posedge clk) if (&{upZ,|idxZ,~&idxZ}) store[idxZ] <= nextZ;
endmodule