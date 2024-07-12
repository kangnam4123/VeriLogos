module LEDnumb(output reg [6:0]LED, input [3:0]SW);
   parameter n0 = ~7'b011_1111;
   parameter n1 = ~7'b000_0110;
   parameter n2 = ~7'b101_1011;
   parameter n3 = ~7'b100_1111;
   parameter n4 = ~7'b110_0110;
   parameter n5 = ~7'b110_1101;
   parameter n6 = ~7'b111_1101;
   parameter n7 = ~7'b000_0111;
   parameter n8 = ~7'b111_1111;
   parameter n9 = ~7'b110_0111;
   parameter na = ~7'b111_0111;
   parameter nb = ~7'b111_1100;
   parameter nc = ~7'b011_1001;
   parameter nd = ~7'b101_1110;
   parameter ne = ~7'b111_1001;
   parameter nf = ~7'b111_0001;
   parameter nx = ~7'b000_0000;
   always @ (SW)
      begin
         case(SW)
            0: LED = n0;
            1: LED = n1;
            2: LED = n2;
            3: LED = n3;
            4: LED = n4;
            5: LED = n5;
            6: LED = n6;
            7: LED = n7;
            8: LED = n8;
            9: LED = n9;
            10: LED = na;
            11: LED = nb;
            12: LED = nc;
            13: LED = nd;
            14: LED = ne;
            15: LED = nf;
            default : LED = nx;
         endcase
      end
endmodule