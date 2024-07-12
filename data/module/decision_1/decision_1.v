module decision_1 (
	input wire clk,
	input wire rst,
	input wire en,
	input wire [14:0] count_ones,
	input wire [14:0] count_runs,
	output reg p_1, p_2
	);
always @(posedge clk)
	if (rst) begin
		p_1 <= 0;
		p_2 <= 0;
	end
	else begin
		if(en)begin
				if (count_ones < 9818) 
					p_1 <= 0;
				else if (count_ones < 9840) begin
					if (count_runs > 10179) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones < 9874) begin
					if (count_runs > 10180) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones < 9921) begin
					if (count_runs > 10181) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones < 10080) begin
					if (count_runs > 10182) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones < 10127) begin
					if (count_runs > 10181) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones <10161) begin
					if (count_runs > 10180) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones <10182) begin
					if (count_runs > 10179) p_1 <= 0;
					else p_1 <= 1;
				end
				else
					p_1 <= 0;
				if (count_ones < 9818) 
					p_2 <= 0;
				else if (count_ones < 9845) begin
					if (count_runs < 9815) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 9883) begin
					if (count_runs < 9816) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 9940) begin
					if (count_runs < 9817) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 10061) begin
					if (count_runs < 9818) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 10118) begin
					if (count_runs < 9817) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 10156) begin
					if (count_runs < 9816) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones <10182) begin
					if (count_runs < 9815) p_2 <= 0;
					else p_2 <= 1;
				end
				else
					p_2 <= 0;
			end
	end
endmodule