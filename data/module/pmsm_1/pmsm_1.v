module pmsm_1 (npm0, npm1, npm2, npm3, pm0, pm1, pm2, pm3, clk, reset);
   output [3:0] pm0, pm1, pm2, pm3;
   input  	clk, reset;
   input [3:0] 	npm0, npm1, npm2, npm3;
   reg [3:0] 	pm0, pm1, pm2, pm3;
   reg [3:0] 	npm0norm, npm1norm, npm2norm, npm3norm;
   always @ (npm0 or npm1 or npm2 or npm3)
	 begin
	   if ((npm0 <= npm1)&&(npm0 <= npm2)&&(npm0 <= npm3))
	     begin
	       npm0norm <= 0;
	       npm1norm <= npm1-npm0;
	       npm2norm <= npm2-npm0;
	       npm3norm <= npm3-npm0;
	     end
	   else if ((npm1 <= npm0)&&(npm1 <= npm2)&&(npm1 <= npm3))
	     begin
	       npm0norm <= npm0-npm1;
	       npm1norm <= 0;
	       npm2norm <= npm2-npm1;
	       npm3norm <= npm3-npm1;
	     end
	   else if ((npm2 <= npm0)&&(npm2 <= npm1)&&(npm2 <= npm3))
	     begin
	       npm0norm <= npm0-npm2;
	       npm1norm <= npm1-npm2;
	       npm2norm <= 0;
	       npm3norm <= npm3-npm2;
	     end
	   else if ((npm3 <= npm0)&&(npm3 <= npm1)&&(npm3 <= npm2))
	     begin
	       npm0norm <= npm0-npm3;
	       npm1norm <= npm1-npm3;
	       npm2norm <= npm2-npm3;
	       npm3norm <= 0;
	     end
	 end 
   always @ (posedge clk)
	 begin
		if (reset)
		  begin
		    pm0 <= 4'd0;
		    pm1 <= 4'd0;
		    pm2 <= 4'd0;
		    pm3 <= 4'd0;
		  end
		else
		  begin
		    pm0 <= npm0norm;
		    pm1 <= npm1norm;
		    pm2 <= npm2norm;
		    pm3 <= npm3norm;
		  end
	 end 
endmodule