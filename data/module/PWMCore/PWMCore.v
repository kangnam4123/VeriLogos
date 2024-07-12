module PWMCore(
    input clk,
    input [15:0] period,
    input [7:0] tOn,
    input enable,
    input reset,
    output pwm
    );
reg [15:0] pwmcounter = 0;
wire rst = ~reset;
reg saida = 0;
always @(posedge clk)
begin
        if(enable & ~rst ) 
        begin
                if(pwmcounter <= tOn)
                    saida <= 1;
                else
                    saida <= 0;
                if(pwmcounter == period)
                    pwmcounter <= 0;
                else
                    pwmcounter <= pwmcounter +1;
        end
        else
            saida <= 0;
        if(rst)
        begin
            pwmcounter <= 0;
            saida <= 0;
        end
end
assign pwm = saida;
endmodule