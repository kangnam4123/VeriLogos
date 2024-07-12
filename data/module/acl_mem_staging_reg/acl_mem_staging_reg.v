module acl_mem_staging_reg #(
  parameter WIDTH       = 32,
  parameter LOW_LATENCY =  0 
)
(
    input wire clk,
    input wire resetn,
    input wire enable,
    input wire [WIDTH-1:0] rdata_in,
    output logic [WIDTH-1:0] rdata_out
);
    generate
        if (LOW_LATENCY) begin
            reg [WIDTH-1:0] rdata_r;
            reg enable_r;
            always @(posedge clk or negedge resetn) begin
               if (!resetn) begin
                  enable_r <= 1'b1;
               end else begin
                  enable_r <= enable;
                  if (enable_r) begin
                      rdata_r <= rdata_in;
                  end
               end
            end
            assign rdata_out = enable_r ? rdata_in : rdata_r;
        end else begin
            reg [WIDTH-1:0] rdata_r[0:1];
            reg [1:0] rdata_vld_r;
            reg enable_r;
            always @(posedge clk or negedge resetn) begin
               if (!resetn) begin
                  rdata_vld_r <= 2'b00;
                  enable_r <= 1'b0;
               end else begin
                  if (~rdata_vld_r[1] | enable) begin
                      enable_r <= enable;
                      rdata_vld_r[0] <= ~enable | (~rdata_vld_r[1] & ~enable_r & enable); 
                      rdata_vld_r[1] <= rdata_vld_r[0] & (rdata_vld_r[1] | ~enable);
                      rdata_r[1] <= rdata_r[0];
                      rdata_r[0] <= rdata_in;
                  end
               end
            end
            always @(*) begin
                case (rdata_vld_r)
                    2'b00: rdata_out = rdata_in;
                    2'b01: rdata_out = rdata_r[0];
                    2'b10: rdata_out = rdata_r[1];
                    2'b11: rdata_out = rdata_r[1];
                    default: rdata_out = {WIDTH{1'bx}};
                endcase
            end
        end
    endgenerate
endmodule