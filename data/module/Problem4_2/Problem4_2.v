module Problem4_2(
    input A,
    input B,
    input C,
    input D,
    input E,
    output X
    );
    assign X = (~A & ~B & ~C & D & ~E) | (~A & ~B & ~C & D & E) | (~A & ~B & C & ~D & E) | (~A & ~B & C & D & E) | (~A & B & ~C & ~D & E) | (~A & B & ~C & D & E) | (~A & B & C & ~D & E) | (A & ~B & ~C & ~D & E) |(A & ~B & ~C & D & E) | (A & ~B & C & D & E) | (A & B & C & ~D & E) | (A & B & C & D & E);
endmodule