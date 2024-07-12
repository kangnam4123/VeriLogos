module Banderas_Alarma(
    input [7:0] Segundos,
	 input [7:0] Minutos,
	 input [7:0] Horas,
    input [7:0] Segundos_RTC,
	 input [7:0] Minutos_RTC,
	 input [7:0] Horas_RTC,
	 input [7:0] Estado,
	 input [7:0] Guardar,
	 input clk,
	 input reset,
	 output reg [7:0] Flag_Pico
    );
	 always @(posedge clk)
	    if (reset)
			begin
				Flag_Pico <= 8'd0;
			end 
		 else 
			 if ((Guardar == 8'h70)&&(Estado == 8'h75))
					begin
						if ((Segundos_RTC == Segundos )&& (Minutos_RTC == Minutos) && (Horas_RTC == Horas ) && (Segundos_RTC != 8'h00) && (Minutos_RTC != 8'h00) && (Horas_RTC != 8'h00))
							begin
								Flag_Pico <= 8'd1;
							end
						else 
						begin
							Flag_Pico <= 8'd0;
						end 
					end
			else 
				begin
					Flag_Pico <= Flag_Pico;
				end
endmodule