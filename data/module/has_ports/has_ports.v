module has_ports (output reg o, input wire a, input wire b);
   always @* o <= a & b;
endmodule