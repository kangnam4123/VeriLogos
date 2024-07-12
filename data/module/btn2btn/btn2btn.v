module btn2btn(clk,rst_n,din,flag);
input clk,rst_n,din;
output reg flag;
reg [31:0] counter;
reg [2:0] state;
parameter SstableHigh=0,SunstableHigh=1,Snegedge=2,SstableLow=3,SunstableLow=4,Sposedge=5;
always @ (posedge clk or negedge rst_n)
if (!rst_n) begin
    state <= SstableHigh;
    counter <= 32'd0;
    flag <= din;
end
else begin
    case(state)
        SstableHigh: begin
            if(din == 1'b1) begin
                state <= SstableHigh;
            end
            else begin
                counter <= 0;
                state <= SunstableHigh;
            end
        end
        SunstableHigh: begin
            if(counter >= 32'd2_000_000) begin
                counter <= 32'd0;
                if ( din == 1'b0 )     state <= Snegedge;
                else    state <= SstableHigh;
            end
            else begin
                counter <= counter + 1;
                state <= SunstableHigh;
            end
        end
        Snegedge: begin
            flag <= 1'b0;
            state <= SstableLow;
        end
        SstableLow: begin
            if(din == 1'b0) begin
                state <= SstableLow;
            end
            else begin
                counter <= 0;
                state <= SunstableLow;
            end
        end
        SunstableLow: begin
            if(counter >= 32'd2_000_000) begin
                counter <= 32'd0;
                if ( din == 1'b1 )     state <= Sposedge;
                else    state <= SstableLow;
            end
            else begin
                counter <= counter + 1;
                state <= SunstableLow;
            end
        end
        Sposedge: begin
            flag <= 1'b1;
            state <= SstableHigh;
        end
    endcase
end
endmodule