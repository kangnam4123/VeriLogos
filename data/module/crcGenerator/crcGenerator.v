module crcGenerator 
#(parameter LEN = 7)(
    input inputBit,
    input clk,
    input clear,                
    input enable,               
    input [LEN:0] generator,
    output reg [LEN - 1:0] crc
    );
wire invert;
assign invert = inputBit ^ crc[LEN - 1];
integer _i = 0;
always @ (posedge clk) begin
    if (clear) begin
        crc = 0;    
        end
    else if (enable) begin
        for (_i = LEN - 1; _i > 0; _i = _i - 1) begin
            crc[_i] = crc[_i - 1] ^ (invert & generator[_i]);  
        end
        crc[0] = invert;
    end
end
endmodule