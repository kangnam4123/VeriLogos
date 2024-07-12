module spiSend(
    spiClock,
    start,
    cmd,
    bitout,
    finish
);
parameter byteSize = 6;
input spiClock;
input start;
input [(byteSize * 8) - 1:0] cmd;
output bitout;
output reg finish;
wire _start;
assign _start = start;
reg _running = 0, _waiting = 0;
reg [(byteSize * 8) - 1:0] _cmdBuffer;
reg [byteSize - 1:0]       _i;
assign bitout = _running ? _cmdBuffer[47] : 1'b1;   
reg _error = 0;
always @ (negedge spiClock) begin
    if (_start && ~_running && ~_waiting) begin
        finish   <= 0;
        _cmdBuffer <= cmd; 
        _running <= 1;
        _i <= 47; 
    end else if (_start && _running && ~_waiting) begin
        _i = _i - 1;
        _cmdBuffer = _cmdBuffer << 1;
        if (_i == 0) begin
            _running <= 0;
            _waiting <= 1;
        end
    end else if (_start && _waiting) begin
        finish   <= 1;
    end else if (~_start) begin
        finish   <= 0;
        _waiting <= 0;
    end else begin
        _error = 1;
    end
end
endmodule