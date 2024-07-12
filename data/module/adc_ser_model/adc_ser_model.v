module adc_ser_model ( 
    input wire CLK, LOAD,
    input wire [13:0] DATA_IN,
    output wire DATA_OUT
);
reg [13:0] ser_reg;
always@(posedge CLK)
    if(LOAD)
        ser_reg <= DATA_IN;
    else
        ser_reg <= {ser_reg[12:0], 1'b0};
assign DATA_OUT = ser_reg[13];
endmodule