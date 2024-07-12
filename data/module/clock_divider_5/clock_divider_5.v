module clock_divider_5(
   clkout, clkout90,
   clkin, divcfg, reset
   );
   input       clkin;    
   input [3:0] divcfg;   
   input       reset;    
   output      clkout;   
   output      clkout90; 
   reg        clkout_reg;
   reg [7:0]  counter;   
   reg [7:0]  divcfg_dec;
   reg [3:0]  divcfg_reg;
   reg [3:0]  divcfg_change;
   wire       div2_sel;
   wire       div1_sel;   
   wire       posedge_match;
   wire       negedge_match;  
   wire       posedge90_match;
   wire       negedge90_match; 
   reg 	      clkout90_div4;
   reg 	      clkout90_div2;
   always @ (divcfg[3:0])
     casez (divcfg[3:0])
	  4'b0001 : divcfg_dec[7:0] = 8'b00000010;  
	  4'b0010 : divcfg_dec[7:0] = 8'b00000100;  
	  4'b0011 : divcfg_dec[7:0] = 8'b00001000;  
	  4'b0100 : divcfg_dec[7:0] = 8'b00010000;  
          4'b0101 : divcfg_dec[7:0] = 8'b00100000;  
          4'b0110 : divcfg_dec[7:0] = 8'b01000000;  
          4'b0111 : divcfg_dec[7:0] = 8'b10000000;  
	  default : divcfg_dec[7:0] = 8'b00000000;   
	endcase
   assign div2_sel = divcfg[3:0]==4'b0001;
   assign div1_sel = divcfg[3:0]==4'b0000;
   always @ (posedge clkin or posedge reset)
     if(reset)              
       divcfg_change <=1'b0;
     else
       begin
	  divcfg_change <= (divcfg_reg[3:0]^divcfg[3:0]);	  
	  divcfg_reg[3:0] <=divcfg[3:0];	  
       end
   always @ (posedge clkin or posedge reset)
     if(reset)
       counter[7:0] <= 8'b000001;
     else      
       if(posedge_match | divcfg_change)
	 counter[7:0] <= 8'b000001;
       else
	 counter[7:0] <= (counter[7:0] + 8'b000001);
   assign posedge_match    = (counter[7:0]==divcfg_dec[7:0]);
   assign negedge_match    = (counter[7:0]=={1'b0,divcfg_dec[7:1]}); 
   assign posedge90_match  = (counter[7:0]==({2'b00,divcfg_dec[7:2]}));
   assign negedge90_match  = (counter[7:0]==({2'b00,divcfg_dec[7:2]} + 
					     {1'b0,divcfg_dec[7:1]})); 
   always @ (posedge clkin or posedge reset)
     if(reset)
       clkout_reg <= 1'b0;   
     else if(posedge_match)
       clkout_reg <= 1'b1;
     else if(negedge_match)
       clkout_reg <= 1'b0;
   assign clkout    = div1_sel ? clkin : clkout_reg;
   always @ (posedge clkin)
     clkout90_div4 <= posedge90_match ? 1'b1 :
                      negedge90_match ? 1'b0 :
		                        clkout90_div4;
   always @ (negedge clkin)
     clkout90_div2 <= negedge_match ? 1'b1 :
                      posedge_match ? 1'b0 :
		                     clkout90_div2;
   assign clkout90  = div2_sel ? clkout90_div2 : clkout90_div4;
endmodule