module a25_coprocessor(
			i_clk,
			i_core_stall,     
			i_copro_crn,      
			i_copro_operation,
			i_copro_write_data, 
			i_fault,       
			i_fault_status,
			i_fault_address,  
			o_copro_read_data,
			o_cache_enable,
			o_cache_flush,
			o_cacheable_area 
		);
input                       i_clk;
input                       i_core_stall;     
input       [3:0]           i_copro_crn;      
input       [1:0]           i_copro_operation;
input       [31:0]          i_copro_write_data;
input                       i_fault;          
input       [7:0]           i_fault_status;
input       [31:0]          i_fault_address;  
output      [31:0]          o_copro_read_data;
output                      o_cache_enable;
output                      o_cache_flush;
output      [31:0]          o_cacheable_area;
reg      [31:0]          o_copro_read_data; 
reg [2:0]  cache_control = 3'b000;
reg [31:0] cacheable_area = 32'h0;
reg [31:0] updateable_area = 32'h0;
reg [31:0] disruptive_area = 32'h0;
reg [7:0]  fault_status  = 8'd0;
reg [31:0] fault_address = 32'b0;  
wire       copro15_reg1_write;
assign o_cache_enable   = cache_control[0];
assign o_cache_flush    = copro15_reg1_write;
assign o_cacheable_area = cacheable_area;
always @ ( posedge i_clk )
    if ( !i_core_stall )
        begin
        if ( i_fault )
            begin
            fault_status    <= i_fault_status;
            fault_address   <= i_fault_address;
            end
        end
always @ ( posedge i_clk )
    if ( !i_core_stall )         
        begin
        if ( i_copro_operation == 2'd2 )
            case ( i_copro_crn )
                4'd2: cache_control   <= i_copro_write_data[2:0];
                4'd3: cacheable_area  <= i_copro_write_data[31:0];
                4'd4: updateable_area <= i_copro_write_data[31:0];
                4'd5: disruptive_area <= i_copro_write_data[31:0];
		default: cache_control <=cache_control;
            endcase
        end
assign copro15_reg1_write = !i_core_stall && i_copro_operation == 2'd2 && i_copro_crn == 4'd1;
always @ ( posedge i_clk )        
    if ( !i_core_stall )
        case ( i_copro_crn )
            4'd0:    o_copro_read_data <= 32'h41560300;
            4'd2:    o_copro_read_data <= {29'd0, cache_control}; 
            4'd3:    o_copro_read_data <= cacheable_area; 
            4'd4:    o_copro_read_data <= updateable_area; 
            4'd5:    o_copro_read_data <= disruptive_area; 
            4'd6:    o_copro_read_data <= {24'd0, fault_status };
            4'd7:    o_copro_read_data <= fault_address;
            default: o_copro_read_data <= 32'd0;
        endcase
endmodule