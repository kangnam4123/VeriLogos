module stack_3(top, clk, pushd, push_en, pop_en);
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 5;
    output [DATA_WIDTH - 1:0]   top;    
    input                       clk;    
    input [DATA_WIDTH - 1:0]    pushd;  
    input                       push_en;
    input                       pop_en; 
    reg [DATA_WIDTH - 1:0] stack_data[0:(1 << ADDR_WIDTH) - 1];
    reg [ADDR_WIDTH - 1:0] stack_ptr;
    reg [DATA_WIDTH - 1:0] stack_top;
    assign top = stack_top;
    integer i;
    initial
    begin
        stack_ptr = 0;
        stack_top = 0;
        for (i = 0; i < (1 << ADDR_WIDTH); i = i + 1)
            stack_data[i] = 0;
    end
    always @(posedge clk)
    begin
        if (push_en)
        begin
            stack_data[stack_ptr] <= stack_top;
            stack_ptr <= stack_ptr + 1'b1;
            stack_top <= pushd;
        end
        else if (pop_en)
        begin
            stack_ptr <= stack_ptr - 1'b1;
            stack_top <= stack_data[stack_ptr - 1'b1];
        end
    end
endmodule