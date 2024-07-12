module Codigo1(clk, ps2_data, ps2_clk, ps2_data_out, pulso_done
    );
	 input clk;
	 input ps2_clk, ps2_data;
	 output [7:0]ps2_data_out;
	 output reg pulso_done;
	 reg [7:0] filtro_antirebote;
	 reg ps2_clk_negedge;
	 reg [2:0] estado=0;
	 reg [7:0] contador=0;
	 reg [7:0] data_p;
	 reg data_in; 
	 localparam [2:0]
	 idle = 3'b000,
	 uno = 3'b001,
	 dos = 3'b010,
	 tres = 3'b011,
	 cuatro = 3'b100;
	 always @ (posedge clk)
	 begin 
	 filtro_antirebote [7:0]<= {ps2_clk, filtro_antirebote[7:1]};
	 end
	 always @ (posedge clk)
	begin 
	if (filtro_antirebote == 8'b00001111)
		ps2_clk_negedge <= 1'b1;
	else
		ps2_clk_negedge <= 1'b0;
	end 
	always @ (posedge clk)
	begin
	if (ps2_clk_negedge)
	data_in <= ps2_data;
	else 
	data_in <= data_in;
	end
	 always @ (posedge clk)
	 begin 
	 case (estado)
	 idle: begin
		data_p <= data_p;
		contador <= 4'd0;
		pulso_done <=1'b0;
			if (ps2_clk_negedge)
				estado<= uno;
			else
				estado<= uno;
			end
		uno: begin
			data_p<=data_p;
			contador <= contador;
			pulso_done <= 1'b0;
			if (ps2_clk_negedge)
			begin 	
				if (contador == 4'd8)
					estado<=tres;
				else 	
					estado <= dos;
				end
					else 
						estado<= uno;
				end
			dos: begin
				data_p [7:0] <= {data_in, data_p[7:1]};
				contador <=  contador +1;
				pulso_done <= 1'b0;
				estado <= uno;
				end
			tres: begin
				estado <= cuatro;
				pulso_done <=1'b1;
				data_p <=data_p;
				contador <= 4'd0;
				end
			cuatro: begin
				data_p <= data_p;
				contador <= 4'd0;
				pulso_done <= 1'b0;
				if (ps2_clk_negedge)
					estado <= idle;
				end
			endcase
			end
			assign  ps2_data_out = data_p;
endmodule