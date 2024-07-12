module spi_i2s_ipi_clk_div
#(
	parameter PARAM_CNT_WIDTH   = 8, 
	parameter PARAM_STAGE_WIDTH = 3  
)(
  output reg clkd_clk_out_o,       
  output clkd_time_base_o,         
  input [clogb2(PARAM_CNT_WIDTH) - 1 : 0] clkd_clk_div_sel_i, 
	input clkd_enable_i,                                        
	input clkd_clk,                                             
	input clkd_rst_n                                            
);
function integer clogb2;
  input [31:0] value;
  reg div2;
  begin
 	  for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
      value = value >> 1;
  end
endfunction
localparam CNT_REST_WIDTH = (PARAM_CNT_WIDTH % PARAM_STAGE_WIDTH); 
localparam STAGE_NUM      = (PARAM_CNT_WIDTH / PARAM_STAGE_WIDTH); 
localparam HAS_REST_CNT   = (CNT_REST_WIDTH != 0);                 
reg [PARAM_STAGE_WIDTH - 1 : 0] cnt_ff[0 : STAGE_NUM - 1];
reg [CNT_REST_WIDTH    - 1 : 0] rest_ff;
wire [PARAM_STAGE_WIDTH - 1 : 0] cnt_ff_in[0 : STAGE_NUM - 1];
wire [PARAM_STAGE_WIDTH - 1 : 0] time_base[0 : STAGE_NUM - 1];
wire [PARAM_CNT_WIDTH   - 1 : 0] clk_div_sel; 
wire [CNT_REST_WIDTH    - 1 : 0] rest_ff_in;
wire [CNT_REST_WIDTH    - 1 : 0] rest_time_base;
wire [PARAM_CNT_WIDTH   - 1 : 0] time_base_array;
generate
	genvar i;
	for(i = 0 ; i < STAGE_NUM; i = i + 1)
		begin
			if(i == 0) 
				begin
          assign cnt_ff_in[0] = cnt_ff[0] + 1'b1;
          assign time_base[0] = cnt_ff[0] ^ cnt_ff_in[0]; 
          always @(posedge clkd_clk)
          	begin
          		if(!clkd_rst_n)
          			cnt_ff[0] <= {PARAM_STAGE_WIDTH{1'b0}}; 
          		else
          			begin
          				if(!clkd_enable_i)
          					cnt_ff[0] <= {PARAM_STAGE_WIDTH{1'b0}};		
          				else
          					cnt_ff[0] <= cnt_ff_in[0];
			          end
	          end
				end
		  else 
        begin
          assign cnt_ff_in[i] = cnt_ff[i] + cnt_ff[i - 1][PARAM_STAGE_WIDTH - 1];
          assign time_base[i] = (cnt_ff[i] ^ cnt_ff_in[i]) & {PARAM_STAGE_WIDTH{time_base[i - 1][PARAM_STAGE_WIDTH - 1]}};
      		always @(posedge clkd_clk)
		        begin
				      if(!clkd_rst_n)
					      cnt_ff[i] <= {PARAM_STAGE_WIDTH{1'b0}}; 
				      else
					      begin
						      if(!clkd_enable_i)
							      cnt_ff[i] <= {PARAM_STAGE_WIDTH{1'b0}};		
						      else
							      if(time_base[i])
							        cnt_ff[i] <= cnt_ff_in[i];
					      end
			      end  
        end
		end
endgenerate
generate
  if(HAS_REST_CNT)
    begin
      assign rest_ff_in     = rest_ff + cnt_ff[STAGE_NUM - 1][PARAM_STAGE_WIDTH - 1];
      assign rest_time_base = (rest_ff ^ rest_ff_in) & {PARAM_STAGE_WIDTH{time_base[STAGE_NUM - 1][PARAM_STAGE_WIDTH - 1]}};
      always @(posedge clkd_clk)
        begin
          if(!clkd_rst_n)
            rest_ff <= {CNT_REST_WIDTH{1'b0}}; 
          else
            begin
	            if(!clkd_enable_i)
		            rest_ff <= {CNT_REST_WIDTH{1'b0}};		
	            else
		            if(rest_time_base)
		              rest_ff <= rest_ff_in;
            end
        end 
    end
endgenerate
assign clk_div_sel = {{PARAM_CNT_WIDTH{1'b0}}, 1'b1} << clkd_clk_div_sel_i;
generate
	genvar j, k;
	for(j = 0; j < STAGE_NUM; j = j + 1)
		for(k = 0; k < PARAM_STAGE_WIDTH; k = k + 1)
			begin
				assign time_base_array[j*PARAM_STAGE_WIDTH + k] = time_base[j][k]; 
			end
	if(HAS_REST_CNT)
		assign time_base_array[STAGE_NUM + PARAM_STAGE_WIDTH + 1 +: CNT_REST_WIDTH] = rest_time_base;
endgenerate
assign clkd_time_base_o = (|(time_base_array & clk_div_sel)) & clkd_enable_i;
always @(posedge clkd_clk) 
	begin
		if(!clkd_rst_n)
			clkd_clk_out_o <= 1'b0;
		else
			if(!clkd_enable_i)
				clkd_clk_out_o <= 1'b0;
			else
				if(clkd_time_base_o)
					clkd_clk_out_o <= ~clkd_clk_out_o;
	end
endmodule