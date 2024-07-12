module shift_out_register
#(parameter WIDTH = 3)
(
    input [WIDTH:0] start,
    input clk,
    input load,
    input shift,
    input [(WIDTH-1):0] D,
    input shift_in,
    output [(WIDTH-1):0] Q,
    output shift_out
);
    reg [(WIDTH-1):0] shift_reg; 
    always @(posedge start[0] or posedge clk) begin
        if (start[0]) begin
            shift_reg <= start[WIDTH:1];
        end
        else begin
            if (load) begin
                shift_reg <= D;
            end
            else if (shift) begin
                if (WIDTH == 1) begin
                    shift_reg <= shift_in;
                end
                else begin
                    shift_reg <= {shift_in, shift_reg[(WIDTH-1):1]};
                end
            end
        end
    end
    assign shift_out = shift_reg[0];
    assign Q = shift_reg; 
endmodule