module S_sel(input[1:0] rot, output reg[0:15] block);
wire[0:15] s0 = 16'b0110110000000000;
wire[0:15] s1 = 16'b0100011000100000;
wire[0:15] s2 = 16'b0000011011000000;
wire[0:15] s3 = 16'b1000110001000000;
always @*
begin
    case(rot)
        0: block = s0;
        1: block = s1;
        2: block = s2;
        3: block = s3;
        default: block = s0;
    endcase
end
endmodule