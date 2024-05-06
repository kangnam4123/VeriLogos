module a25_multiply (
			i_clk,
			i_core_stall,
			i_a_in,        
			i_b_in,       
			i_function,
			i_execute,
			o_out,
			o_flags,        
			o_done                                  
		);
input                       i_clk;
input                       i_core_stall;
input       [31:0]          i_a_in;         
input       [31:0]          i_b_in;         
input       [1:0]           i_function;
input                       i_execute;
output      [31:0]          o_out;
output      [1:0]           o_flags;        
output                      o_done;   
reg         o_done = 1'd0;
wire	    enable;
wire        accumulate;
wire [33:0] multiplier;
wire [33:0] multiplier_bar;
wire [33:0] sum;
wire [33:0] sum34_b;
reg  [5:0]  count = 6'd0;
reg  [5:0]  count_nxt;
reg  [67:0] product = 68'd0;
reg  [67:0] product_nxt;
reg  [1:0]  flags_nxt;
wire [32:0] sum_acc1;           
assign enable         = i_function[0];
assign accumulate     = i_function[1];
assign multiplier     =  { 2'd0, i_a_in} ;
assign multiplier_bar = ~{ 2'd0, i_a_in} + 34'd1 ;
assign sum34_b        =  product[1:0] == 2'b01 ? multiplier     :
                         product[1:0] == 2'b10 ? multiplier_bar :
                                                 34'd0          ;
    assign sum =  product[67:34] + sum34_b;
    assign sum_acc1 = {1'd0, product[32:1]} + {1'd0, i_a_in};
always @(*)
    begin
    flags_nxt   = { product[32], product[32:1] == 32'd0 }; 
    if ( count == 6'd0 )
        product_nxt = {33'd0, 1'd0, i_b_in, 1'd0 } ;
    else if ( count <= 6'd33 )
        product_nxt = { sum[33], sum, product[33:1]} ;
    else if ( count == 6'd34 && accumulate )
        begin
        product_nxt         = { product[64:33], sum_acc1[31:0], 1'd0}; 
        end
    else
        product_nxt         = product;
    if (count == 6'd0)  
        count_nxt   = enable ? 6'd1 : 6'd0;
    else if ((count == 6'd34 && !accumulate) ||  
             (count == 6'd35 &&  accumulate)  )  
        count_nxt   = 6'd0;
    else
        count_nxt   = count + 1'd1;
    end
always @ ( posedge i_clk )
    if ( !i_core_stall )
        begin
        count           <= i_execute ? count_nxt          : count;           
        product         <= i_execute ? product_nxt        : product;        
        o_done          <= i_execute ? count == 6'd31     : o_done;          
        end
assign o_out   = product[32:1]; 
assign o_flags = flags_nxt;
endmodule