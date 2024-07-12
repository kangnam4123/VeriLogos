module bloque_prueba_frames
(
input wire [1:0]sw,
output reg [3:0] digit0_HH, digit1_HH, digit0_MM, digit1_MM, digit0_SS, digit1_SS,
digit0_DAY, digit1_DAY, digit0_MES, digit1_MES, digit0_YEAR, digit1_YEAR,
digit0_HH_T, digit1_HH_T, digit0_MM_T, digit1_MM_T, digit0_SS_T, digit1_SS_T,
output reg AM_PM,
output reg [1:0]funcion,
output reg [1:0] cursor_location,
output reg timer_end,
output reg formato_hora
);
always@*
begin
case(sw)
2'h0:
begin
	digit0_HH = 4'b0000;
	digit1_HH = 4'b0001;
	digit0_MM = 4'b0010; 
	digit1_MM = 4'b0011;
	digit0_SS = 4'b0100;
	digit1_SS = 4'b0101;
	digit0_DAY = 4'b0110;
	digit1_DAY = 4'b0111;
	digit0_MES = 4'b1000;
	digit1_MES = 4'b1001;
	digit0_YEAR = 4'b0000;
	digit1_YEAR = 4'b0001;
	digit0_HH_T = 4'b0010; 
	digit1_HH_T = 4'b0011;
	digit0_MM_T = 4'b0100;
	digit1_MM_T = 4'b0101;
	digit0_SS_T = 4'b0110;
	digit1_SS_T = 4'b0111;
	AM_PM = 1'b0;
	funcion = 2'b00;
	cursor_location = 2'b00;
	timer_end = 1'b1;
	formato_hora = 1'b1;
end
2'h1:
begin
	digit0_HH = 4'b0010;
	digit1_HH = 4'b0011;
	digit0_MM = 4'b0100; 
	digit1_MM = 4'b0101;
	digit0_SS = 4'b0110;
	digit1_SS = 4'b0111;
	digit0_DAY = 4'b1000;
	digit1_DAY = 4'b1001;
	digit0_MES = 4'b0000;
	digit1_MES = 4'b0001;
	digit0_YEAR = 4'b0010;
	digit1_YEAR = 4'b0011;
	digit0_HH_T = 4'b0100; 
	digit1_HH_T = 4'b0101;
	digit0_MM_T = 4'b0110;
	digit1_MM_T = 4'b0111;
	digit0_SS_T = 4'b1000;
	digit1_SS_T = 4'b1001;
	AM_PM = 1'b1;
	funcion = 2'b01;
	cursor_location = 2'b10;
	timer_end = 1'b0;
	formato_hora = 1'b1;
end
2'h2:
begin
	digit0_HH = 4'b1001;
	digit1_HH = 4'b0000;
	digit0_MM = 4'b0001; 
	digit1_MM = 4'b0010;
	digit0_SS = 4'b0011;
	digit1_SS = 4'b0100;
	digit0_DAY = 4'b0101;
	digit1_DAY = 4'b0110;
	digit0_MES = 4'b0111;
	digit1_MES = 4'b1000;
	digit0_YEAR = 4'b1001;
	digit1_YEAR = 4'b0000;
	digit0_HH_T = 4'b0001; 
	digit1_HH_T = 4'b0010;
	digit0_MM_T = 4'b0011;
	digit1_MM_T = 4'b0100;
	digit0_SS_T = 4'b0101;
	digit1_SS_T = 4'b0110;
	AM_PM = 1'b0;
	funcion = 2'b10;
	cursor_location = 2'b01;
	timer_end = 1'b0;
	formato_hora = 1'b0;
end
2'h3:
begin
	digit0_HH = 4'b0111;
	digit1_HH = 4'b0110;
	digit0_MM = 4'b0101; 
	digit1_MM = 4'b0100;
	digit0_SS = 4'b0011;
	digit1_SS = 4'b0011;
	digit0_DAY = 4'b0010;
	digit1_DAY = 4'b0001;
	digit0_MES = 4'b0000;
	digit1_MES = 4'b1001;
	digit0_YEAR = 4'b1000;
	digit1_YEAR = 4'b0111;
	digit0_HH_T = 4'b0110; 
	digit1_HH_T = 4'b0101;
	digit0_MM_T = 4'b0100;
	digit1_MM_T = 4'b0011;
	digit0_SS_T = 4'b0010;
	digit1_SS_T = 4'b0001;
	AM_PM = 1'b0;
	funcion = 2'b11;
	cursor_location = 2'b00;
	timer_end = 1'b0;
	formato_hora = 1'b0;
end
endcase
end
endmodule