module Decodificador(
   input [6:0] Cuenta,
	output reg [7:0] catodo1,catodo2,catodo3,catodo4
    );
	 always @(*)
	    begin
	    case (Cuenta)
		    6'd0: begin
			           catodo1 <= 8'b00000011;
						  catodo2 <= 8'b00000011;
					     catodo3 <= 8'b00000011;
					     catodo4 <= 8'b00000011;
			        end 
			 6'd1: begin
						 catodo1 <= 8'b10011111;
						 catodo2 <= 8'b00000011;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011; 
			        end 
			 6'd2: begin
						 catodo1 <= 8'b00100101;
						 catodo2 <= 8'b00000011;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd3: begin
						 catodo1 <= 8'b00001101;
						 catodo2 <= 8'b00000011;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd4: begin
						 catodo1 <= 8'b10011001;
						 catodo2 <= 8'b00000011;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd5: begin
						 catodo1 <= 8'b01001001;
						 catodo2 <= 8'b00000011;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd6: begin
						 catodo1 <= 8'b01000001;
						 catodo2 <= 8'b00000011;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd7: begin
						 catodo1 <= 8'b00011111;
						 catodo2 <= 8'b00000011;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd8: begin
						 catodo1 <= 8'b00000001;
						 catodo2 <= 8'b00000011;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd9: begin
						 catodo1 <= 8'b00011001;
						 catodo2 <= 8'b00000011;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd10: begin
						 catodo1 <= 8'b00000011;
						 catodo2 <= 8'b10011111;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd11: begin
						 catodo1 <= 8'b10011111;
						 catodo2 <= 8'b10011111;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd12: begin
						 catodo1 <= 8'b00100101;
						 catodo2 <= 8'b10011111;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd13: begin
						 catodo1 <= 8'b00001101;
						 catodo2 <= 8'b10011111;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd14: begin
						 catodo1 <= 8'b10011001;
						 catodo2 <= 8'b10011111;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 6'd15: begin
						 catodo1 <= 8'b01001001;
						 catodo2 <= 8'b10011111;
						 catodo3 <= 8'b00000011;
						 catodo4 <= 8'b00000011;
			        end 
			 default: begin
						 catodo1 <= 8'b10011111;
						 catodo2 <= 8'b10011111;
						 catodo3 <= 8'b10011111; 
						 catodo4 <= 8'b10011111;
                   end 	
        endcase		
		end	 
endmodule