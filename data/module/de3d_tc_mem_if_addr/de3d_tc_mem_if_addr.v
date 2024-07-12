module de3d_tc_mem_if_addr
	(
	input	[8:0]	ul_store_x,	
	input	[8:0]	ul_store_y,	
	input	[8:0]	ll_store_x,	
	input	[8:0]	ll_store_y,	
	input	[8:0]	ur_store_x,	
	input	[8:0]	ur_store_y,	
	input	[8:0]	lr_store_x,	
	input	[8:0]	lr_store_y,	
	input   [2:0]   bank,           
	input   [2:0]   bpt,            
	input		tc_ready,	
	input	[7:0]	ram_addr,	
	input	[3:0]	set_read,	
	output reg	[7:0]	addr_out	
	);
wire           ul_lru_read = set_read[3];
wire           ll_lru_read = set_read[2];
wire           ur_lru_read = set_read[1];
wire           lr_lru_read = set_read[0];
always @* begin
     	case (bpt) 
        	3'h3: 	begin
          			if ({(ul_store_x[4] ^ ul_store_y[0]),ul_store_x[3:2]} == bank) 
					addr_out={ul_lru_read,ul_store_y[5:0],ul_store_x[5]};
          			else if ({(ll_store_x[4] ^ ll_store_y[0]),ll_store_x[3:2]} == bank) 
					addr_out={ll_lru_read,ll_store_y[5:0],ll_store_x[5]};
          			else if ({(ur_store_x[4] ^ ur_store_y[0]),ur_store_x[3:2]} == bank) 
					addr_out={ur_lru_read,ur_store_y[5:0],ur_store_x[5]};
          			else if ({(lr_store_x[4] ^ lr_store_y[0]),lr_store_x[3:2]} == bank) 
					addr_out={lr_lru_read,lr_store_y[5:0],lr_store_x[5]};
				else addr_out = 8'hff;
        		end
        	3'h4: 	begin
          			if ({(ul_store_x[3] ^ ul_store_y[0]),ul_store_x[2:1]} == bank) 
					addr_out={ul_lru_read,ul_store_y[4:0],ul_store_x[5:4]};
          			else if ({(ll_store_x[3] ^ ll_store_y[0]),ll_store_x[2:1]} == bank) 
					addr_out={ll_lru_read,ll_store_y[4:0],ll_store_x[5:4]};
          			else if ({(ur_store_x[3] ^ ur_store_y[0]),ur_store_x[2:1]} == bank) 
					addr_out={ur_lru_read,ur_store_y[4:0],ur_store_x[5:4]};
          			else if ({(lr_store_x[3] ^ lr_store_y[0]),lr_store_x[2:1]} == bank) 
					addr_out={lr_lru_read,lr_store_y[4:0],lr_store_x[5:4]};
				else addr_out = 8'hff;
        		end
        	default:
        	 	begin
          			if ({(ul_store_x[2] ^ ul_store_y[0]),ul_store_x[1:0]} == bank) 
					addr_out={ul_lru_read,ul_store_y[3:0],ul_store_x[5:3]};
          			else if ({(ll_store_x[2] ^ ll_store_y[0]),ll_store_x[1:0]} == bank) 
					addr_out={ll_lru_read,ll_store_y[3:0],ll_store_x[5:3]};
          			else if ({(ur_store_x[2] ^ ur_store_y[0]),ur_store_x[1:0]} == bank) 
					addr_out={ur_lru_read,ur_store_y[3:0],ur_store_x[5:3]};
          			else if ({(lr_store_x[2] ^ lr_store_y[0]),lr_store_x[1:0]} == bank) 
					addr_out={lr_lru_read,lr_store_y[3:0],lr_store_x[5:3]};
				else addr_out = 8'hff;
        		end
      		endcase
end
endmodule