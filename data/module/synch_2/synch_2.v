module synch_2 #(parameter WIDTH = 1) (
   input  wire [WIDTH-1:0] i,      
   output reg  [WIDTH-1:0] o,      
   input  wire             clk     
);
reg [WIDTH-1:0] stage_1;
always @(posedge clk)
   {o, stage_1} <= {stage_1, i};
endmodule