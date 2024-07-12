module t_inst
  (
   output reg [7:0] osizedreg,
   output wire oonewire ,
   input [7:0] isizedwire,
   input wire ionewire
   );
   assign oonewire = ionewire;
   always @* begin
      osizedreg = isizedwire;
   end
endmodule