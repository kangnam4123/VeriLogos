module mor1kx_cache_lru(
   update, lru_pre, lru_post,
   current, access
   );
   parameter NUMWAYS = 2;
   localparam WIDTH = NUMWAYS*(NUMWAYS-1) >> 1;
   input [WIDTH-1:0]        current;
   output reg [WIDTH-1:0]   update;
   input [NUMWAYS-1:0]      access;
   output reg [NUMWAYS-1:0] lru_pre;
   output reg [NUMWAYS-1:0] lru_post;
   reg [NUMWAYS-1:0]        expand [0:NUMWAYS-1];
   integer              i, j;
   integer              offset;
   always @(*) begin : comb
      offset = 0;
      for (i = 0; i < NUMWAYS; i = i + 1) begin
         expand[i][i] = 1'b1;
         for (j = i + 1; j < NUMWAYS; j = j + 1) begin
            expand[i][j] = current[offset+j-i-1];
         end
         for (j = 0; j < i; j = j + 1) begin
            expand[i][j] = !expand[j][i];
         end
         offset = offset + NUMWAYS - i - 1;
      end 
      for (i = 0; i < NUMWAYS; i = i + 1) begin
         lru_pre[i] = &expand[i];
      end
      for (i = 0; i < NUMWAYS; i = i + 1) begin
         if (access[i]) begin
            for (j = 0; j < NUMWAYS; j = j + 1) begin
               if (i != j) begin
                  expand[i][j] = 1'b0;
               end
            end
            for (j = 0; j < NUMWAYS; j = j + 1) begin
               if (i != j) begin
                  expand[j][i] = 1'b1;
               end
            end
         end
      end 
      offset = 0;
      for (i = 0; i < NUMWAYS; i = i + 1) begin
         for (j = i + 1; j < NUMWAYS; j = j + 1) begin
            update[offset+j-i-1] = expand[i][j];
         end
         offset = offset + NUMWAYS - i - 1;
      end
      for (i = 0; i < NUMWAYS; i = i + 1) begin
         lru_post[i] = &expand[i];
      end
   end
endmodule