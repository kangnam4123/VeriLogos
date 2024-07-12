module T_sel(input[1:0] rot, output reg[0:15] block);
wire[0:15] t0 = 16'b1110010000000000;
wire[0:15] t1 = 16'b0010011000100000;
wire[0:15] t2 = 16'b0000010011100000;
wire[0:15] t3 = 16'b1000110010000000;
always @*
begin
    case(rot)
        0: block = t0;
        1: block = t1;
        2: block = t2;
        3: block = t3;
        default: block = t0;
    endcase
end
endmodule