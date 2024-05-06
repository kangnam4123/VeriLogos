module sparc_exu_aluadder64
  (
   rs1_data,
   rs2_data,
   cin,
   adder_out,
   cout32,
   cout64
   );
   input [63:0]  rs1_data;   
   input [63:0]  rs2_data;   
   input         cin;           
   output [63:0] adder_out; 
   output         cout32;         
   output         cout64;         
   assign      {cout32, adder_out[31:0]} = rs1_data[31:0]+rs2_data[31:0]+
                                           cin;
   assign      {cout64, adder_out[63:32]} = rs1_data[63:32] 
               + rs2_data[63:32] + cout32;
endmodule