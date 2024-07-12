module alu_58 #(parameter WIDTH=32)
      (input [WIDTH-1:0] a,b,
       input [5:0] aluop,
       output reg [WIDTH-1:0] result);
    wire [30:0] b2;
    assign b2=a[30:0];
    wire [WIDTH-1:0] sum,slt,shamt;
    always @(*)
        begin
            case(aluop)
                6'b000000: result<=(b<<a);
                6'b000010: result<=(b>>a);
                6'b000011: result<=(b>>>a);
                6'b001000: result<= 32'b0;
                6'b100000: result<=(a+b);
                6'b100001: result<=(a+b);
                6'b100010: result<=(a-b);
                6'b100011: result<=(a-b);
                6'b100110: result<=(a^b);
                6'b100100: result<=(a&b);
                6'b100101: result<=(a|b);
                6'b100111: result<=~(a&b);
                6'b101010: result<=(a<b? 1:0);
                6'b000001: 
		            begin
			            result<=(a<0 ? 0:1);
		            end
                6'b001010: 
                    begin
                        result<=(a>0 ? 0:1);
                    end
	            6'b010001: result<=((b<<16)& 32'b11111111111111110000000000000000);
            endcase
        end
endmodule