module fifo_52 # (parameter abits = 400, dbits = 8)(
    input  reset, clock,
    input  rd, wr,
    input  [dbits-1:0] din,
    output [dbits-1:0] dout,
    output empty,
    output full,
    output reg ledres
    );
wire db_wr;
wire db_rd;
reg dffw1, dffr1;
reg [dbits-1:0] out;
initial ledres = 0;
reg [1:0] count;
reg [1:0] count1;
assign db_wr = dffw1; 
assign db_rd = dffr1; 
reg [dbits-1:0] regarray[2**abits-1:0]; 
reg [abits-1:0] wr_reg, wr_next, wr_succ; 
reg [abits-1:0] rd_reg, rd_next, rd_succ; 
reg full_reg, empty_reg, full_next, empty_next;
assign wr_en = db_wr & ~full; 
always @ (posedge clock)
begin
	if(wr && ~rd)
	begin
		if(count)
		begin
		dffw1<=0;
		count<=count+1;
		end		
		else 
		begin	
		dffw1<=1;
		count<=0;
		end
	end
	else dffw1<=0;
end
always @ (posedge clock)
begin
	if(rd && ~wr)
	begin
		if(count1)
		begin
		dffr1<=0;
		count1<=count1+1;
		end		
		else 
		begin
		dffr1<=1;
		count1<=0;
		end
	end
	else dffr1<=0;
end
always @ (posedge clock)
 begin
  if(wr_en)
   regarray[wr_reg] <= din;  
 end
always @ (posedge clock)
 begin
  if(db_rd)
   out <= regarray[rd_reg];
 end
always @ (posedge clock or posedge reset)
 begin
  if (reset)
   begin
   wr_reg <= 0;
   rd_reg <= 0;
   full_reg <= 1'b0;
   empty_reg <= 1'b1;
   ledres=0;
   end
  else
   begin
   wr_reg <= wr_next; 
   rd_reg <= rd_next;
   full_reg <= full_next;
   empty_reg <= empty_next;
   ledres=1;
   end
 end
always @(clock)
 begin
  wr_succ = wr_reg + 1; 
  rd_succ = rd_reg + 1; 
  wr_next = wr_reg;  
  rd_next = rd_reg;  
  full_next = full_reg;  
  empty_next = empty_reg;  
   case({db_wr,db_rd})
    2'b01: 
     begin
      if(~empty) 
       begin
        rd_next = rd_succ;
        full_next = 1'b0;
       if(rd_succ == wr_reg) 
         empty_next = 1'b1;  
       end
     end
2'b10: 
     begin
      if(~full) 
       begin
        wr_next = wr_succ;
        empty_next = 1'b0;
        if(wr_succ == (2**abits-1)) 
         full_next = 1'b1;   
       end
     end
    2'b11: 
     begin
      wr_next = wr_succ;
      rd_next = rd_succ;
     end
    endcase
 end
assign full = full_reg;
assign empty = empty_reg;
assign dout = out;
endmodule