module counter_8 #(
        parameter WIDTH = 0,
        parameter MODULUS = 0
    )(
        input                   clk,
        input                   ce,
        input                   clr,
        output [WIDTH - 1:0]    out
   );
    reg[WIDTH - 1:0] mem = 0;
    always@(posedge clk)
    begin
        if(clr)
            mem[WIDTH - 1:0] <= 0;
        else
        begin
            if(ce)
                mem <= (mem + 1) % MODULUS;
            else
                mem <= mem;
        end
    end
    assign out = mem;
endmodule