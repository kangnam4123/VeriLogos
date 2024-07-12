module rf_2p_be (
				clka    ,  
				cena_i  ,
		        addra_i ,
		        dataa_o ,
				clkb    ,     
				cenb_i  ,   
				wenb_i  ,   
				addrb_i	,  
				datab_i
);
parameter     		Word_Width=32;
parameter	  		Addr_Width=8;
parameter			Byte_Width=(Word_Width>>3);
input                     clka;      
input   		          cena_i;    
input   [Addr_Width-1:0]  addra_i;   
output	[Word_Width-1:0]  dataa_o;   
input                     clkb;      
input   		          cenb_i;    
input   [Byte_Width-1:0]  wenb_i;    
input   [Addr_Width-1:0]  addrb_i;   
input   [Word_Width-1:0]  datab_i;   
reg    [Word_Width-1:0]   mem_array[(1<<Addr_Width)-1:0];
reg	   [Word_Width-1:0]  dataa_r;
reg	   [Word_Width-1:0]  datab_w;
wire   [Word_Width-1:0]  datab_m;
always @(posedge clka) begin
	if (!cena_i)
		dataa_r <= mem_array[addra_i];
	else
		dataa_r <= 'bx;
end
assign dataa_o = dataa_r;
assign datab_m = mem_array[addrb_i];
genvar j;
generate
	for (j=0; j<Byte_Width; j=j+1) begin:j_n
		always@(*) begin
			datab_w[(j+1)*8-1:j*8] = wenb_i[j] ? datab_m[(j+1)*8-1:j*8]:datab_i[(j+1)*8-1:j*8];
		end
	end
endgenerate
always @(posedge clkb) begin                
	if(!cenb_i && !(&wenb_i)) 
		mem_array[addrb_i] <= datab_w;
end
endmodule