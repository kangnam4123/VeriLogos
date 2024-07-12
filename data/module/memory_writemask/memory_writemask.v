module memory_writemask(
   we,
   write, datamode, addr
   );
   input         write;   
   input [1:0]   datamode;   
   input [2:0]   addr;
   output [7:0]  we;
   reg [7:0] 	 we;
   always@*
     casez({write, datamode[1:0],addr[2:0]})
       6'b100000 : we[7:0] = 8'b00000001;
       6'b100001 : we[7:0] = 8'b00000010;
       6'b100010 : we[7:0] = 8'b00000100;
       6'b100011 : we[7:0] = 8'b00001000;
       6'b100100 : we[7:0] = 8'b00010000;
       6'b100101 : we[7:0] = 8'b00100000;
       6'b100110 : we[7:0] = 8'b01000000;
       6'b100111 : we[7:0] = 8'b10000000;
       6'b10100? : we[7:0] = 8'b00000011;
       6'b10101? : we[7:0] = 8'b00001100;
       6'b10110? : we[7:0] = 8'b00110000;
       6'b10111? : we[7:0] = 8'b11000000;
       6'b1100?? : we[7:0] = 8'b00001111;
       6'b1101?? : we[7:0] = 8'b11110000;       
       6'b111??? : we[7:0] = 8'b11111111;
       default   : we[7:0] = 8'b00000000;
     endcase 
endmodule