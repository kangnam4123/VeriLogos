module COMPARATOR #(parameter               WIDTH = 32)
                   (input  wire [WIDTH-1:0] DIN0,
                    input  wire [WIDTH-1:0] DIN1,
                    output wire [WIDTH-1:0] DOUT0,
                    output wire [WIDTH-1:0] DOUT1);
  wire comp_rslt = (DIN0 < DIN1);
  function [WIDTH-1:0] mux;
    input [WIDTH-1:0] a;
    input [WIDTH-1:0] b;
    input             sel;
    begin
      case (sel)
        1'b0: mux = a;
        1'b1: mux = b;
      endcase
    end
  endfunction
  assign DOUT0 = mux(DIN1, DIN0, comp_rslt);
  assign DOUT1 = mux(DIN0, DIN1, comp_rslt);
endmodule