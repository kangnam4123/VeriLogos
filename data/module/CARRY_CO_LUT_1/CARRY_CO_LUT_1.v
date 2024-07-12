module CARRY_CO_LUT_1(input CO, input O, input S, input DI, output OUT);
assign OUT = O ^ S;
endmodule