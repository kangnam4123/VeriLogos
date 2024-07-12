module simple_dual_ram_47 #(
         parameter SIZE = 8,                
         parameter DEPTH = 8                
       )(
         input wclk,                        
         input [$clog2(DEPTH)-1:0] waddr,   
         input [SIZE-1:0] write_data,       
         input write_en,                    
         input rclk,                        
         input [$clog2(DEPTH)-1:0] raddr,   
         output reg [SIZE-1:0] read_data    
       );
reg [SIZE-1:0] mem [DEPTH-1:0];      
always @(posedge wclk) begin
  if (write_en)                      
    mem[waddr] <= write_data;        
end
always @(posedge rclk) begin
  read_data <= mem[raddr];           
end
endmodule