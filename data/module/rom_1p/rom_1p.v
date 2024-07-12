module rom_1p (
				clk     ,
				cen_i   ,
				oen_i   ,
				addr_i  ,
				data_o
);
parameter     	Word_Width = 32;
parameter		Addr_Width = 8;
input                     clk;      
input   		          cen_i;    
input   		          oen_i;    
input   [Addr_Width-1:0]  addr_i;   
output	[Word_Width-1:0]  data_o;   
reg    [Word_Width-1:0]   mem_array[(1<<Addr_Width)-1:0];
reg	   [Word_Width-1:0]  data_r;
always @(posedge clk) begin 
	if (!cen_i)
		data_r <= mem_array[addr_i];
	else
		data_r <= 'bx;
end
assign data_o = oen_i ? 'bz : data_r;
endmodule