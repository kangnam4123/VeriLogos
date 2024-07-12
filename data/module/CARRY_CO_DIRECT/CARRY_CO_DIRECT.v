module CARRY_CO_DIRECT(input CO, input O, input S, input DI, output OUT);
parameter TOP_OF_CHAIN = 1'b0;
assign OUT = CO;
endmodule