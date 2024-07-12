module register_file_12(input clk,input we3,
                     input [3:0]a1,input [3:0]a2,input [3:0]a3,
                     input [31:0] wd3,input [31:0] r15,
                     output [31:0]rd1 ,output[31:0] rd2 
                    );
                    reg[31:0] mem[0:14];
                    always@(posedge clk)
							if(we3) mem[a3]<=wd3;
					assign rd1 = (a1 == 4'b1111) ? r15 : mem[a1];
					assign rd2 = (a2 == 4'b1111) ? r15 : mem[a2];
endmodule