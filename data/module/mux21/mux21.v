module mux21 ( dataa, datab, dataout, outputselect);
	input dataa;
	input datab;
	output dataout;
	input outputselect;
	reg tmp_result;
    integer i;
    always @(dataa or datab or outputselect)
	begin
		tmp_result = 0;
		if (outputselect)
		begin
	        tmp_result = datab;
		end
		else
		begin
	        tmp_result = dataa;
		end
	end
    assign dataout = tmp_result;
endmodule