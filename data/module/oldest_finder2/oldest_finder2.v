module oldest_finder2 #(
			parameter ENTLEN = 1,
			parameter VALLEN = 8
			)
  (
   input wire [2*ENTLEN-1:0] entvec,
   input wire [2*VALLEN-1:0] valvec,
   output wire [ENTLEN-1:0]  oldent,
   output wire [VALLEN-1:0]  oldval
   );
   wire [ENTLEN-1:0] 	     ent1 = entvec[0+:ENTLEN];
   wire [ENTLEN-1:0] 	     ent2 = entvec[ENTLEN+:ENTLEN];
   wire [VALLEN-1:0] 	     val1 = valvec[0+:VALLEN];
   wire [VALLEN-1:0] 	     val2 = valvec[VALLEN+:VALLEN];
   assign oldent = (val1 < val2) ? ent1 : ent2;
   assign oldval = (val1 < val2) ? val1 : val2;
endmodule