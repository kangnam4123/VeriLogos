module CNORM_1 (CLK,
ED,
START,
DR,
DI,
SHIFT,
OVF,
RDY,
DOR,
DOI);
	parameter nb=16;
	output OVF ;
	reg OVF;
	output RDY ;
	reg RDY;
	output [nb+1:0] DOR ;
	wire [nb+1:0] DOR;
	output [nb+1:0] DOI ;
	wire [nb+1:0] DOI;
	input CLK ;
	wire CLK;
	input ED ;
	wire ED;
	input START ;
	wire START;
	input [nb+2:0] DR ;
	wire [nb+2:0] DR;
	input [nb+2:0] DI ;
	wire [nb+2:0] DI;
	input [1:0] SHIFT ;
	wire [1:0] SHIFT;
	reg [nb+2:0] diri,diii;
	always @ (DR or SHIFT) begin
		case (SHIFT)
			2'h0: begin
				diri = DR;
			end
			2'h1: begin
				diri[(nb+2):1] = DR[(nb+2)-1:0];
				diri[0:0] = 1'b0;
			end
			2'h2: begin
				diri[(nb+2):2] = DR[(nb+2)-2:0];
				diri[1:0] = 2'b00;
			end
			2'h3: begin
				diri[(nb+2):3] = DR[(nb+2)-3:0];
				diri[2:0] = 3'b000;
			end
		endcase
	end
	always @ (DI or SHIFT) begin
		case (SHIFT)
			2'h0: begin
				diii = DI;
			end
			2'h1: begin
				diii[(nb+2):1] = DI[(nb+2)-1:0];
				diii[0:0] = 1'b0;
			end
			2'h2: begin
				diii[(nb+2):2] = DI[(nb+2)-2:0];
				diii[1:0] = 2'b00;
			end
			2'h3: begin
				diii[(nb+2):3] = DI[(nb+2)-3:0];
				diii[2:0] = 3'b000;
			end
		endcase
	end
reg [nb+2:0]	dir,dii;
    always @( posedge CLK )    begin
			if (ED)	  begin
					dir<=diri[nb+2:1];
     				dii<=diii[nb+2:1];
		end
	end
 always @( posedge CLK ) 	begin
		  	if (ED)	  begin
				RDY<=START;
				if (START)
					OVF<=0;
				else
					case (SHIFT)
					2'b01 : OVF<= (DR[nb+2] != DR[nb+1]) || (DI[nb+2] != DI[nb+1]);
					2'b10 : OVF<= (DR[nb+2] != DR[nb+1]) || (DI[nb+2] != DI[nb+1]) ||
						(DR[nb+2] != DR[nb]) || (DI[nb+2] != DI[nb]);
					2'b11 : OVF<= (DR[nb+2] != DR[nb+1]) || (DI[nb+2] != DI[nb+1])||
						(DR[nb+2] != DR[nb]) || (DI[nb+2] != DI[nb]) ||
						(DR[nb+2] != DR[nb+1]) || (DI[nb-1] != DI[nb-1]);
					endcase
				end
			end
	assign DOR= dir;
	assign DOI= dii;
endmodule