module mux_in #(parameter WIDTH = 8)
             (input  wire [WIDTH-1:0] d0, d1, d2, d3, 
              input  wire [1:0]            s, 
              output wire [WIDTH-1:0] y);
    reg [7:0] aux;
    always @(d0,d1,d2,d3,s)
    begin
      case (s)              
        2'b00: aux = d0;
        2'b01: aux = d1;
        2'b10: aux = d2;
        2'b11: aux = d3;
        default: aux = 8'bxxxxxxxx; 
      endcase
    end                 
  assign y = aux; 
endmodule