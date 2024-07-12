module ag6502_clock(input phi_0, output phi_1, output phi_2);
	wire phi_01;
	not#3(phi_1,phi_0);
	or(phi_01,~phi_0, phi_1);
	not#1(phi_2, phi_01);
endmodule