module reg_pipeline
    #(
      parameter C_DEPTH = 10,
      parameter C_WIDTH = 10
      )
    (
     input                CLK,
     input                RST_IN,
     input [C_WIDTH-1:0]  WR_DATA,
     input                WR_DATA_VALID,
     output               WR_DATA_READY,
     output [C_WIDTH-1:0] RD_DATA,
     output               RD_DATA_VALID,
     input                RD_DATA_READY
     );
    genvar                i;
    wire                  wReady [C_DEPTH:0];
    reg [C_WIDTH-1:0]     _rData [C_DEPTH:1], rData [C_DEPTH:0];
    reg                   _rValid [C_DEPTH:1], rValid [C_DEPTH:0];
    assign wReady[C_DEPTH] = RD_DATA_READY;
    assign RD_DATA = rData[C_DEPTH];
    assign RD_DATA_VALID = rValid[C_DEPTH];
    assign WR_DATA_READY = wReady[0];
    always @(*) begin
        rData[0] = WR_DATA;
        rValid[0] = WR_DATA_VALID;
    end
    generate
        for( i = 1 ; i <= C_DEPTH; i = i + 1 ) begin : gen_stages
            assign #1 wReady[i-1] =  ~rValid[i] | wReady[i];
            always @(*) begin
                _rData[i] = rData[i-1];
            end
            always @(posedge CLK) begin
                if(wReady[i-1]) begin
                    rData[i] <= #1 _rData[i];
                end
            end
            always @(*) begin
                if(RST_IN) begin
                    _rValid[i] = 1'b0;
                end else begin
                    _rValid[i] = rValid[i-1] | (rValid[i] & ~wReady[i]);
                end
            end
            always @(posedge CLK) begin
                rValid[i] <= #1 _rValid[i];
            end
        end
    endgenerate
endmodule