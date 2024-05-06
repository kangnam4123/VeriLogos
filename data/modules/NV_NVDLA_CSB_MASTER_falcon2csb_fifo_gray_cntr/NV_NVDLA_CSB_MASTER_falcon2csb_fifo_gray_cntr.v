module NV_NVDLA_CSB_MASTER_falcon2csb_fifo_gray_cntr (
      clk
    , reset_
    , inc
    , gray
    );
input clk;
input reset_;
input inc;
output [2:0] gray;
reg [2:0] gray; 
wire polarity; 
assign polarity = gray[0] ^ gray[1] ^ gray[2];
  always @( posedge clk or negedge reset_ ) begin
    if ( !reset_ ) begin
 gray <= 3'd0;
    end else if ( inc ) begin
        gray <= { gray[2]^(polarity &~gray[0]),
                         gray[1]^(polarity&gray[0]),
                         gray[0]^(~polarity) };
    end
end
endmodule