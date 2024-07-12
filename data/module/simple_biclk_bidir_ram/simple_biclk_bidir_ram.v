module simple_biclk_bidir_ram
  #(parameter width = 1,
    parameter widthad = 1)
    (
     input                  clk,
     input [widthad-1:0]    address_a,
     input                  wren_a,
     input [width-1:0]      data_a,
     output reg [width-1:0] q_a,
     input                  clk2,
     input [widthad-1:0]    address_b,
     output reg [width-1:0] q_b
     );
    reg [width-1:0]         mem [(2**widthad)-1:0];
    always @(posedge clk) begin
        if(wren_a) mem[address_a] <= data_a;
        q_a <= mem[address_a];
    end
    always @(posedge clk2) begin
        q_b <= mem[address_b];
    end
endmodule