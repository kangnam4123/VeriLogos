module des_comp_gen_fx_color
  (
   input 	       clk,
   input 	       rstn,
   input signed [31:0] dx_fx, 
   input signed [31:0] dy_fx, 
   input [95:0]        cmp_i,
   output [7:0]        curr_i
   );
  reg signed [57:0]    ix;
  reg signed [57:0]    iy;
  reg signed [57:0]    ixy;
  reg signed [19:0]    curr;
  assign curr_i = (curr[19]) ? 8'h00 :	
		  (curr[18]) ? 8'hff :	
		  curr[17:10];		
  wire [17:0] 	       sp_fx;
  wire signed [25:0]   idx_fx;
  wire signed [25:0]   idy_fx;
  assign sp_fx  = flt_fx_8p10(cmp_i[95:64]);
  assign idx_fx = flt_fx_16p10(cmp_i[63:32]);
  assign idy_fx = flt_fx_16p10(cmp_i[31:0]);
  always @(posedge clk) begin
    ix        <= dx_fx * idx_fx;			
    iy        <= dy_fx * idy_fx;			
    ixy       <= iy + ix;				
    curr      <= ixy[35:16] + {2'b00, sp_fx};	
  end
  function [25:0] flt_fx_16p10;
    input	[31:0]	fp_in;         
    reg [7:0] 		bias_exp;       
    reg [7:0] 		bias_exp2;      
    reg [47:0] 		bias_mant;      
    reg [47:0] 		int_fixed_out;
    reg [31:0] 		fixed_out;
    begin
      bias_mant = {25'h0001, fp_in[22:0]};
      bias_exp = fp_in[30:23] - 8'd127;
      bias_exp2 = ~bias_exp + 8'h1;
      if (fp_in[30:0] == 31'b0) int_fixed_out = 0;
      else if (bias_exp[7]) int_fixed_out = bias_mant >> bias_exp2;
      else int_fixed_out = bias_mant << bias_exp;
      fixed_out = int_fixed_out[38:13];
      flt_fx_16p10 = (fp_in[31]) ? ~fixed_out[25:0] + 26'h1 : fixed_out[25:0];
    end
  endfunction
  function [17:0] flt_fx_8p10;
    input	[31:0]	fp_in;         
    reg [7:0] 		bias_exp;       
    reg [7:0] 		bias_exp2;      
    reg [47:0] 		bias_mant;      
    reg [47:0] 		int_fixed_out;
    reg [31:0] 		fixed_out;
    begin
      bias_mant = {25'h0001, fp_in[22:0]};
      bias_exp = fp_in[30:23] - 8'd127;
      bias_exp2 = ~bias_exp + 8'h1;
      if (fp_in[30:0] == 31'b0) int_fixed_out = 0;
      else if (bias_exp[7]) int_fixed_out = bias_mant >> bias_exp2;
      else int_fixed_out = bias_mant << bias_exp;
      fixed_out = int_fixed_out[31:13];
      flt_fx_8p10 = (fp_in[31]) ? ~fixed_out[17:0] + 18'h1 : fixed_out[17:0];
    end
  endfunction
endmodule