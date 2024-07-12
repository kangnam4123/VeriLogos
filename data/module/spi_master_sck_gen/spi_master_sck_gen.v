module spi_master_sck_gen
    #(parameter CPOL = 0,
      parameter CPHA = 0)
    (input wire i_period,
     input wire i_xfer,
     output wire o_sck);
localparam mode = {CPOL[0], CPHA[0]};
generate
if(mode == 0) begin
    assign o_sck = i_period & i_xfer;
end else if(mode == 1) begin
    assign o_sck = ~i_period & i_xfer;
end else if(mode == 2) begin
    assign o_sck = ~i_period | ~i_xfer;
end else begin
    assign o_sck = i_period | ~i_xfer;
end
endgenerate
endmodule