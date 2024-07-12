module multiplexor32a1 #(parameter Width = 3)
 (coeff00,coeff01,coeff02,coeff03,coeff04,coeff05,coeff06,coeff07,coeff08,coeff09,
  coeff10,coeff11,coeff12,coeff13,coeff14,coeff15,coeff16,coeff17,coeff18,coeff19,
  coeff20,coeff21,coeff22,coeff23,coeff24,coeff25,coeff26,coeff27,coeff28,coeff29, 
  coeff30,coeff31,SEL,outMUX);
  input [4:0] SEL;
  input signed  [Width-1:0] coeff00,coeff01,coeff02,coeff03,coeff04,coeff05,coeff06,coeff07,coeff08,coeff09,
  coeff10,coeff11,coeff12,coeff13,coeff14,coeff15,coeff16,coeff17,coeff18,coeff19,
  coeff20,coeff21,coeff22,coeff23,coeff24,coeff25,coeff26,coeff27,coeff28,coeff29, 
  coeff30,coeff31;
  output reg signed [Width-1:0] outMUX;
  always @*begin
		case (SEL)
         5'd00: outMUX <= coeff00;
         5'd01: outMUX <= coeff01;
         5'd02: outMUX <= coeff02;
         5'd03: outMUX <= coeff03;
         5'd04: outMUX <= coeff04;
         5'd05: outMUX <= coeff05;
         5'd06: outMUX <= coeff06;
         5'd07: outMUX <= coeff07;
			5'd08: outMUX <= coeff08;
         5'd09: outMUX <= coeff09;
			5'd10: outMUX <= coeff10;
         5'd11: outMUX <= coeff11;
         5'd12: outMUX <= coeff12;
         5'd13: outMUX <= coeff13;
         5'd14: outMUX <= coeff14;
         5'd15: outMUX <= coeff15;
         5'd16: outMUX <= coeff16;
         5'd17: outMUX <= coeff17;
			5'd18: outMUX <= coeff18;
         5'd19: outMUX <= coeff19;
			5'd20: outMUX <= coeff20;
         5'd21: outMUX <= coeff21;
         5'd22: outMUX <= coeff22;
         5'd23: outMUX <= coeff23;
         5'd24: outMUX <= coeff24;
         5'd25: outMUX <= coeff25;
         5'd26: outMUX <= coeff26;
         5'd27: outMUX <= coeff27;
			5'd28: outMUX <= coeff28;
         5'd29: outMUX <= coeff29;	
			5'd30: outMUX <= coeff30;
         5'd31: outMUX <= coeff31;
      endcase
  end
endmodule