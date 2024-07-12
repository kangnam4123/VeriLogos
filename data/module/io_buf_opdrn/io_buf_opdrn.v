module io_buf_opdrn (datain, dataout);
	input  datain;
	output dataout;
	reg tmp_tridata;
	always @(datain)
	begin
        if (datain == 0)
		begin
			tmp_tridata = 1'b0;
		end
        else 
		begin
			tmp_tridata = 1'bz;	
		end
	end
	assign dataout = tmp_tridata;
endmodule