module Alu_3(
    input [31:0] input1,    
	 input [31:0] input2,
    input [3:0] aluCtr,
    output reg zero,
    output reg [31:0] aluRes
    );
	 always @(input1 or input2 or aluCtr)
	 begin
	 case(aluCtr)
	   'b0000:	begin                     
		aluRes = input1 & input2;
		zero = 0;
		end
		'b0001:  begin                     
		aluRes = input1 | input2;
		zero = 0;
		end
		'b0010:  begin                     
		aluRes = input1 + input2;
		zero = 0;
		end
		'b0110:  begin                     
			aluRes = input1 - input2;
			if(aluRes == 0)	zero = 1;				
			else zero = 0;
		end
		'b0111:  begin		
			zero = 0;
			if(input1<input2)  aluRes = 1;
			else aluRes = 0;
		end
		'b1100:  begin               		  
			aluRes = ~(input1 | input2);
			zero = 0;
		end
	endcase
	end
endmodule