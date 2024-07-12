module RAM_7 (O, A);
    parameter INIT = 16'h0000;
    output O;
    input [3:0] A;
    reg  mem [15:0];
    reg  [4:0] count;
    wire [3:0] adr;
    buf (O, mem[A]);
    initial
    begin
	for (count = 0; count < 16; count = count + 1)
	    mem[count] <= INIT[count];
    end
endmodule