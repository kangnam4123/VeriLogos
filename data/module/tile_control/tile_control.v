module tile_control #(
parameter SIZE = 16'd125,			
parameter LOOP = 16'd100,			
parameter PRV_SIZE = 16'd10,		
parameter PRV_LOOP = 16'd10		
)(
input clk_i,
input rst_i,
input ram_full_i,
input pipeline_lock_i,
input data_available_i,
output reg en_o = 0,
output reg proc_unit_rst_o = 0,
output reg ram_wr_o = 0,
output wire ram_rd_o,
output reg [$clog2(SIZE) - 1'b1:0] sig_mux_sel_o = 0,
output reg idle_o = 0
);
localparam 	READY	 	= 4'b0001,
				PROCESS 	= 4'b0010,
				TRANSFER = 4'b0100,
				WAIT	 	= 4'b1000;
reg [3:0] CURRENT_STATE = READY;
reg [$clog2(PRV_SIZE*PRV_LOOP) - 1'b1:0] iteration_cnt = 0;	
reg [$clog2(LOOP):0] loop_cnt = 0;
reg process_flag = 0;
assign ram_rd_o = process_flag & !pipeline_lock_i;
always@(posedge clk_i) begin
	if(rst_i) begin
		en_o 					<= 0;
		ram_wr_o 			<= 0;
		sig_mux_sel_o 		<= 0;
		iteration_cnt  	<= 0;
		loop_cnt 			<= 0;
		idle_o 				<= 0;
		proc_unit_rst_o	<= 1;
		CURRENT_STATE <= READY;
	end
	else begin
		proc_unit_rst_o <= 0;
		case(CURRENT_STATE)
			READY: begin
				idle_o <= 1;
				if(data_available_i) begin
					idle_o <= 0;
					process_flag <= 1;
					CURRENT_STATE <= PROCESS;
				end
			end
			PROCESS: begin
				if(!pipeline_lock_i)
					iteration_cnt <= iteration_cnt + 1'd1;
				if(iteration_cnt == PRV_SIZE*PRV_LOOP - 1 && !pipeline_lock_i)				
					process_flag <= 0;
				if(iteration_cnt == PRV_SIZE*PRV_LOOP) begin
					iteration_cnt	<= 0;
					ram_wr_o 		<= 1;
					loop_cnt			<= loop_cnt + 1'b1;
					CURRENT_STATE	<= TRANSFER;
				end
				en_o <= process_flag && !pipeline_lock_i;
			end
			TRANSFER: begin
				sig_mux_sel_o <= sig_mux_sel_o + 1'b1;
				if(sig_mux_sel_o == SIZE - 1'b1) begin
					sig_mux_sel_o 		<= 0;
					ram_wr_o 			<= 0;
					proc_unit_rst_o 	<= 1;
					if(loop_cnt < LOOP) begin
						process_flag <= 1;
						CURRENT_STATE <= PROCESS;
					end	
					else begin
						CURRENT_STATE <= WAIT;
						loop_cnt <= 0;
					end
				end
			end
			WAIT: begin
				if(!ram_full_i) begin
					idle_o <= 1;
					CURRENT_STATE <= READY;
				end
			end
		endcase
	end
end
endmodule