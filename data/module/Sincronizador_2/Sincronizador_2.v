module Sincronizador_2( _clk_, boton_arriba_in, boton_abajo_in, boton_izq_in, boton_der_in, boton_elige_in,
								boton_arriba_out, boton_abajo_out, boton_izq_out, boton_der_out, boton_elige_out);
 input boton_arriba_in, boton_abajo_in, boton_izq_in, boton_der_in, boton_elige_in, _clk_;
 output reg boton_arriba_out, boton_abajo_out, boton_izq_out, boton_der_out, boton_elige_out;
 localparam contador_max= 20'd1000000;
 reg boton_arriba_sync_0;
 reg boton_abajo_sync_0;
 reg boton_izq_sync_0;
 reg boton_der_sync_0;
 reg boton_elige_sync_0;
 always @(posedge _clk_) 
	begin
		boton_arriba_sync_0 <= boton_arriba_in;
		boton_abajo_sync_0  <= boton_abajo_in;
		boton_izq_sync_0    <= boton_izq_in;
		boton_der_sync_0    <= boton_der_in;
		boton_elige_sync_0  <= boton_elige_in;
	end
 reg boton_arriba_sync_1;
 reg boton_abajo_sync_1;
 reg boton_izq_sync_1;
 reg boton_der_sync_1;
 reg boton_elige_sync_1;
 always @(posedge _clk_) 
	begin
		boton_arriba_sync_1 <= boton_arriba_sync_0;
		boton_abajo_sync_1  <= boton_abajo_sync_0;
		boton_izq_sync_1    <= boton_izq_sync_0;
		boton_der_sync_1    <= boton_der_sync_0;
		boton_elige_sync_1  <= boton_elige_sync_0;
	end
 reg [19:0] contador=0;
 reg [3:0] sr_boton_arriba= 4'b0, sr_boton_abajo= 4'b0, sr_boton_izq= 4'b0, sr_boton_der= 4'b0, sr_boton_elige= 4'b0;
 	always @(posedge _clk_)
	begin 
		if (contador == contador_max)
			contador <= 1'b0;	
		else
			contador <= contador + 1'b1;
	end
 always @(posedge _clk_) 
	begin
		if (contador==contador_max) begin
			sr_boton_arriba <= (sr_boton_arriba << 1)  | boton_arriba_sync_1;
			sr_boton_abajo  <= (sr_boton_abajo  << 1)  | boton_abajo_sync_1;
			sr_boton_izq    <= (sr_boton_izq    << 1)  | boton_izq_sync_1;
			sr_boton_der    <= (sr_boton_der    << 1)  | boton_der_sync_1;
			sr_boton_elige  <= (sr_boton_elige  << 1)  | boton_elige_sync_1;
		end
		case (sr_boton_arriba)
					4'b0000: boton_arriba_out <= 0;
					4'b1111: boton_arriba_out <= 1;
		endcase
		case (sr_boton_abajo)
					4'b0000: boton_abajo_out <= 0;
					4'b1111: boton_abajo_out <= 1;
		endcase
		case (sr_boton_izq)
					4'b0000: boton_izq_out <= 0;
					4'b1111: boton_izq_out <= 1;
		endcase
		case (sr_boton_der)
					4'b0000: boton_der_out <= 0;
					4'b1111: boton_der_out <= 1;
		endcase
		case (sr_boton_elige)
					4'b0000: boton_elige_out <= 0;
					4'b1111: boton_elige_out <= 1;
		endcase
	end
endmodule