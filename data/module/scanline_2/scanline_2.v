module scanline_2 (nextpixel, we, datain, pixeldata, globalreset, clk);
    input nextpixel; 
    input we; 
    input[62:0] datain; 
    output[20:0] pixeldata; 
    reg[20:0] pixeldata;
    input globalreset; 
    input clk; 
    reg[6:0] addr; 
    reg[6:0] waddr; 
    reg[6:0] raddr; 
    reg[1:0] subitem; 
    reg wedelayed; 
    reg[62:0]mem1; 
    reg[62:0]mem2; 
    wire[62:0] mdataout; 
    assign mdataout = mem2 ;
    always @(posedge clk)
    begin
       if (globalreset == 1'b1)
       begin
          subitem <= 2'b00 ; 
          waddr <= 1;
          raddr <= 1;
          wedelayed <= 1'b0 ; 
          pixeldata <= 1;
       end
       else
       begin
          wedelayed <= we ; 
          if (nextpixel == 1'b1 | wedelayed == 1'b1)
          begin
             case (subitem)
                2'b00 :
                         begin
                            pixeldata <= mdataout[62:42] ; 
                         end
                2'b01 :
                         begin
                            pixeldata <= mdataout[41:21] ; 
                         end
                2'b10 :
                         begin
                            pixeldata <= mdataout[20:0] ; 
                         end
                default :
                         begin
                            pixeldata <= 1;
                         end
             endcase 
          end 
          if (nextpixel == 1'b1)
          begin
             case (subitem)
                2'b00 :
                         begin
                            subitem <= 2'b01 ; 
                         end
                2'b01 :
                         begin
                            subitem <= 2'b10 ; 
                         end
                2'b10 :
                         begin
                            subitem <= 2'b00 ; 
                            if (raddr != 7'b1101010)
                            begin
                               raddr <= raddr + 1 ; 
                            end
                            else
                            begin
                               raddr <= 1;
                            end 
                         end
             endcase 
          end 
          if (we == 1'b1)
          begin
             if (waddr != 7'b1101010)
             begin
                waddr <= waddr + 1 ; 
             end
             else
             begin
                waddr <= 1;
             end 
          end 
       end 
     end 
	always @(posedge clk)
	begin
       addr <= raddr ; 
       if (we == 1'b1)
       begin
          mem1 <= datain ; 
          mem2 <= mem1 ; 
       end  
	end
 endmodule