module cia_timerd
(
  input   clk,            
  input clk7_en,
  input  wr,            
  input   reset,           
  input   tlo,          
  input   tme,          
  input  thi,           
  input  tcr,          
  input   [7:0] data_in,      
  output   reg [7:0] data_out,    
  input  count,            
  output  irq            
);
  reg    latch_ena;        
  reg   count_ena;        
  reg    crb7;          
  reg    [23:0] tod;        
  reg    [23:0] alarm;      
  reg    [23:0] tod_latch;    
  reg    count_del;        
always @(posedge clk)
  if (clk7_en) begin
    if (reset)
      latch_ena <= 1'd1;
    else if (!wr)
    begin
      if (thi && !crb7) 
        latch_ena <= 1'd0;
      else if (tlo) 
        latch_ena <= 1'd1;
    end
  end
always @(posedge clk)
  if (clk7_en) begin
    if (latch_ena)
      tod_latch[23:0] <= tod[23:0];
  end
always @(*)
  if (!wr)
  begin
    if (thi) 
      data_out[7:0] = tod_latch[23:16];
    else if (tme) 
      data_out[7:0] = tod_latch[15:8];
    else if (tlo) 
      data_out[7:0] = tod_latch[7:0];
    else if (tcr) 
      data_out[7:0] = {crb7,7'b000_0000};
    else
      data_out[7:0] = 8'd0;
  end
  else
    data_out[7:0] = 8'd0;
always @(posedge clk)
  if (clk7_en) begin
    if (reset)
      count_ena <= 1'd1;
    else if (wr && !crb7) 
    begin
      if (thi) 
        count_ena <= 1'd0;
      else if (tlo) 
        count_ena <= 1'd1;
    end
  end
always @(posedge clk)
  if (clk7_en) begin
    if (reset) 
    begin
      tod[23:0] <= 24'd0;
    end
    else if (wr && !crb7) 
    begin
      if (tlo)
        tod[7:0] <= data_in[7:0];
      if (tme)
        tod[15:8] <= data_in[7:0];
      if (thi)
        tod[23:16] <= data_in[7:0];
    end
    else if (count_ena && count)
      tod[23:0] <= tod[23:0] + 24'd1;
  end
always @(posedge clk)
  if (clk7_en) begin
    if (reset) 
    begin
      alarm[7:0] <= 8'b1111_1111;
      alarm[15:8] <= 8'b1111_1111;
      alarm[23:16] <= 8'b1111_1111;
    end
    else if (wr && crb7) 
    begin
      if (tlo)
        alarm[7:0] <= data_in[7:0];
      if (tme)
        alarm[15:8] <= data_in[7:0];
      if (thi)
        alarm[23:16] <= data_in[7:0];
    end
  end
always @(posedge clk)
  if (clk7_en) begin
    if (reset)
      crb7 <= 1'd0;
    else if (wr && tcr)
      crb7 <= data_in[7];
  end
always @(posedge clk)
  if (clk7_en) begin
    count_del <= count & count_ena;
  end
assign irq = (tod[23:0]==alarm[23:0] && count_del) ? 1'b1 : 1'b0;
endmodule