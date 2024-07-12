module ForwardingJudgment(
			  input [1:0] twobeforeop1,
			  input [2:0] twobeforeop2,twobeforecond,
			  input [3:0] twobeforeop3,
			  input [1:0] beforeop1,
			  input [2:0] beforeop2,beforecond,
			  input [3:0] beforeop3,
			  input [1:0] op1,
			  input [2:0] op2,cond,
			  input [3:0] op3,
                          output      one_A, one_B, two_A, two_B, MW_One, MW_Two);
   reg 				      oA, oB, tA, tB, mwo, mwt;
   always @ (op1 or op2 or cond or op3 or beforeop1 or beforeop2 or beforecond or beforeop3) begin
      if (((beforeop1 == 2'b11 
      	    && beforeop3 >= 4'b0000
            && beforeop3 <= 4'b1100
	    && beforeop3 != 4'b0101
	    && beforeop3 != 4'b0111)
           || (beforeop1 == 2'b10 && beforeop2 == 3'b001))
          && ((op1 == 2'b11 && ((op3 >= 4'b0000
                                 && op3 <= 4'b0110)
                                || op3 == 4'b1101)))
	  && op2 == beforecond)
        oA <= 1'b1;
      else
        oA <= 1'b0;
   end
   always @ (op1 or op2 or cond or op3 or twobeforeop1 or twobeforeop2 or twobeforecond or twobeforeop3) begin
      if (((twobeforeop1 == 2'b11
            && twobeforeop3 >= 4'b0000
	    && twobeforeop3 <= 4'b1100
	    && twobeforeop3 != 4'b0101
	    && twobeforeop3 != 4'b0111)
           || (twobeforeop1 == 2'b10 && twobeforeop2 == 3'b001))
          && ((op1 == 2'b11 && ((op3 >= 4'b0000
                                 && op3 <= 4'b0110)
                                || op3 == 4'b1101)))
	  && op2 == twobeforecond)
        tA <= 1'b1;
      else
        tA <= 1'b0;
   end
   always @ (op1 or op2 or cond or op3 or beforeop1 or beforeop2 or beforecond or beforeop3) begin
      if (((beforeop1 == 2'b11
            && beforeop3 >= 4'b0000
	    && beforeop3 <= 4'b1100
	    && beforeop3 != 4'b0101
	    && beforeop3 != 4'b0111)
           || (beforeop1 == 2'b10 && (beforeop2 == 3'b001 || beforeop2 == 3'b000)))
          && ((op1 == 2'b11 && ((op3 >= 4'b0000
                                 && op3 <= 4'b0101)
                                || (op3 >= 4'b1000
       	                            && op3 <= 4'b1011)))
              || (op1 == 2'b01)
              || (op1 == 2'b00)
              || (op1 == 2'b10 && (op2 == 3'b001
                                   || op2 == 3'b010
                                   || op2 == 3'b110)))
	  && cond == beforecond)
        oB <= 1'b1;
      else
        oB <= 1'b0;
   end
   always @ (op1 or op2 or cond or op3 or twobeforeop1 or twobeforeop2 or twobeforecond or twobeforeop3) begin
      if (((twobeforeop1 == 2'b11
            && twobeforeop3 >= 4'b0000
	    && twobeforeop3 <= 4'b1100
	    && twobeforeop3 != 4'b0101
	    && twobeforeop3 != 4'b0111)
           || (twobeforeop1 == 2'b10 && (twobeforeop2 == 3'b001 || twobeforeop2 == 3'b000)))
          && ((op1 == 2'b11 && ((op3 >= 4'b0000
	                         && op3 <= 4'b0101)
                                || (op3 >= 4'b1000
				    && op3 <= 4'b1011)))
              || (op1 == 2'b01)
              || (op1 == 2'b00)
              || (op1 == 2'b10 && (op2 == 3'b001
	                           || op2 == 3'b010
				   || op2 == 3'b110)))
	  && cond == twobeforecond)
        tB <= 1'b1;
      else
        tB <= 1'b0;
   end
   always @ (op1 or op2 or cond or op3 or beforeop1 or beforeop2 or beforecond or beforeop3) begin
      if (((beforeop1 == 2'b11 
      	    && beforeop3 >= 4'b0000
            && beforeop3 <= 4'b1100
	    && beforeop3 != 4'b0101
	    && beforeop3 != 4'b0111)
           || (beforeop1 == 2'b10 && (beforeop2 == 3'b001 || beforeop2 == 3'b000)))
          && (op1 == 2'b01 && op2 == beforecond)
	      || (((op1 == 2'b10 && op2 == 3'b010)
                    || (op1 == 2'b10 && op2 == 3'b110)) 
		   && cond == beforecond))
        mwo <= 1'b1;
      else
        mwo <= 1'b0;
   end
   always @ (op1 or op2 or cond or op3 or twobeforeop1 or twobeforeop2 or twobeforecond or twobeforeop3) begin
      if (((twobeforeop1 == 2'b11
            && twobeforeop3 >= 4'b0000
	    && twobeforeop3 <= 4'b1100
	    && twobeforeop3 != 4'b0101
	    && twobeforeop3 != 4'b0111)
           || (twobeforeop1 == 2'b10 && (twobeforeop2 == 3'b001 || twobeforeop2 == 3'b000)))
          && (op1 == 2'b01 && op2 == twobeforecond)
	      || (((op1 == 2'b10 && op2 == 3'b010)
	            || (op1 == 2'b10 && op2 == 3'b110))
		   && cond == twobeforecond))
        mwt <= 1'b1;
      else
        mwt <= 1'b0;
   end
   assign one_A = oA;
   assign one_B = oB;
   assign two_A = tA;
   assign two_B = tB;
   assign MW_One = mwo;
   assign MW_Two = mwt;
endmodule