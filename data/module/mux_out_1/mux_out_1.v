module mux_out_1 #(parameter WIDTH = 8)
             (input  wire [WIDTH-1:0] e0, e1, 
              input  wire             s, enable, 
              input  wire [1:0]       reg_, 
              output reg [WIDTH-1:0] d0, d1, d2, d3 );
  wire [7:0] aux;
  assign aux = s ? e1 : e0;
  always @(reg_,aux)
  begin
    case (reg_)
      2'b00: d0 = aux;
      2'b01: d1 = aux;
      2'b10: d2 = aux;
      2'b11: d3 = aux;
    endcase
  end
endmodule