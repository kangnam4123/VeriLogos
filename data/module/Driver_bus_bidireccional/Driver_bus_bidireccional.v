module Driver_bus_bidireccional(
	input clk,
	input in_flag_escritura,
	input in_flag_lectura,
	input in_direccion_dato,
	input [7:0]in_dato,
	output reg [7:0]out_reg_dato,
	input [7:0]addr_RAM,
	inout tri [7:0]dato 
    );
reg [7:0]dato_secundario;
reg [7:0]next_out_dato;
assign dato = (in_flag_escritura)? dato_secundario : 8'bZ;
always@(posedge clk) begin
	out_reg_dato <= next_out_dato;
end
always @(*)
begin
	case({in_flag_escritura,in_flag_lectura,in_direccion_dato})
		3'b000: begin dato_secundario = 8'd0; 
		next_out_dato = out_reg_dato;
		end
		3'b011: begin dato_secundario = 8'd0;
		next_out_dato = dato;
		end 
		3'b100: begin dato_secundario = addr_RAM;
		next_out_dato = out_reg_dato;
		end 
		3'b101: begin  dato_secundario = in_dato;
		next_out_dato = out_reg_dato;
		end
		default: begin
		dato_secundario = 8'd0; 
		next_out_dato = out_reg_dato;
		end
	endcase
end
endmodule