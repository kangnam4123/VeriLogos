module Mux4(select,data_i00,data_i01,data_i02,data_i03,data_o);
   parameter Size = 8;
   input wire [('d2) - ('b1):0] select;
   input wire [(Size) - ('b1):0] data_i00;
   input wire [(Size) - ('b1):0] data_i01;
   input wire [(Size) - ('b1):0] data_i02;
   input wire [(Size) - ('b1):0] data_i03;
   output reg [(Size) - ('b1):0] data_o;
   always @ (select or 
	     data_i00 or data_i01 or data_i02 or data_i03) begin
      case (select)
	'b00: data_o = data_i00;
	'b01: data_o = data_i01;
	'b10: data_o = data_i02;
	'b11: data_o = data_i03;
      endcase
   end
endmodule