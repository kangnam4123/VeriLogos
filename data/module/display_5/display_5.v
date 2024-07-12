module display_5 (
   anode, cathode,
   clk, segment0, segment1, segment2, segment3
   ) ;
   input clk;
   input [3:0]  segment0;
   input [3:0]  segment1;
   input [3:0]  segment2;
   input [3:0]  segment3;
   output [3:0] anode;
   output [7:0] cathode;
   reg [3:0]    anode   = 4'hF;
   reg [7:0]    cathode = 8'h00;
   reg [31:0]   timer_count = 32'h0000_0000;
   wire         timer_expired = (timer_count == 32'd100000);
   always @(posedge clk)
     if (timer_expired) begin
        timer_count <= 32'h0000_0000;        
     end else begin
        timer_count <= timer_count + 1;        
     end
   function [7:0] map_segments;
      input [3:0] data_in;
      begin
         case (data_in)
           4'h0: map_segments = 8'b11000000;
           4'h1: map_segments = 8'b11111001;
           4'h2: map_segments = 8'b10100100;
           4'h3: map_segments = 8'b10110000;
           4'h4: map_segments = 8'b10011001;
           4'h5: map_segments = 8'b10010010;           
           4'h6: map_segments = 8'b10000010;
           4'h7: map_segments = 8'b11111000;
           4'h8: map_segments = 8'b10000000;
           4'h9: map_segments = 8'b10011000;
           default map_segments = 8'b10000000;           
         endcase 
      end      
   endfunction 
   reg [1:0] state      = 2'b00;
   reg [1:0] next_state = 2'b00;
   always @(posedge clk)
     state <= next_state;
   always @(*) begin
      case (state)
        2'b00 : begin
           anode = 4'b1110;
           cathode = map_segments(segment0);  
           next_state = (timer_expired) ? 2'b01: 2'b00;           
        end
        2'b01 : begin
           anode = 4'b1101;
           cathode = map_segments(segment1);
           next_state = (timer_expired) ? 2'b10: 2'b01;           
        end
        2'b10 : begin
           anode = 4'b1011;
           cathode = map_segments(segment2);
           next_state = (timer_expired) ? 2'b11: 2'b10;           
        end
        2'b11 : begin
           anode = 4'b0111;
           cathode = map_segments(segment3);
           next_state = (timer_expired) ? 2'b00: 2'b11;           
        end
      endcase 
   end
endmodule