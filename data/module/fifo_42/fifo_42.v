module fifo_42(datain, rd, wr, rst, clk, dataout, full, empty);
input [7:0] datain;
input rd, wr, rst, clk;
output [7:0] dataout;
output full, empty;
wire [7:0] dataout;
reg full_in, empty_in;
reg [7:0] mem [15:0];
reg [3:0] rp, wp;
assign full = full_in;
assign empty = empty_in;
assign dataout = mem[rp];
always@(posedge clk) begin
    if(wr && ~full_in) mem[wp]<=datain;
end
always@(posedge clk or negedge rst) begin
    if(!rst) wp<=0;
    else begin
      if(wr && ~full_in) wp<= wp+1'b1;
    end
end
always@(posedge clk or negedge rst)begin
    if(!rst) rp <= 0;
    else begin
      if(rd && ~empty_in) rp <= rp + 1'b1;
    end
end
always@(posedge clk or negedge rst) begin
    if(!rst) full_in <= 1'b0;
    else begin
      if( (~rd && wr)&&((wp==rp-1)||(rp==4'h0&&wp==4'hf)))
          full_in <= 1'b1;
      else if(full_in && rd) full_in <= 1'b0;
    end
end
always@(posedge clk or negedge rst) begin
    if(!rst) empty_in <= 1'b1;
    else begin
      if((rd&&~wr)&&(rp==wp-1 || (rp==4'hf&&wp==4'h0)))
        empty_in<=1'b1;
      else if(empty_in && wr) empty_in<=1'b0;
    end
end
endmodule