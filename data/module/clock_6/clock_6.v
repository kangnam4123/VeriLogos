module clock_6 (
    clk,
    reset,
    en,
    count_vec,
    pm,
    LED_vec
);
input clk;
input reset;
input en;
input [23:0] count_vec;
output pm;
reg pm;
input [41:0] LED_vec;
reg [3:0] count [0:6-1];
reg [6:0] LED [0:6-1];
always @(posedge clk, posedge reset) begin: CLOCK_COUNTER
    if (reset == 1) begin
        count[0] <= 0;
        count[1] <= 0;
        count[2] <= 0;
        count[3] <= 0;
        count[4] <= 0;
        count[5] <= 0;
    end
    else begin
        if (en) begin
            count[0] <= ((count[0] + 1) % 10);
            count[1] <= ((count[1] + (count[0] == 9)) % 6);
            count[2] <= ((count[2] + ((count[0] == 9) && (count[1] == 5))) % 10);
            count[3] <= ((count[3] + ((count[0] == 9) && (count[1] == 5) && (count[2] == 9))) % 6);
            count[4] <= (((count[4] + ((count[0] == 9) && (count[1] == 5) && (count[2] == 9) && (count[3] == 5))) % (10 - (7 * count[5]))) + ((count[0] == 9) && (count[1] == 5) && (count[2] == 9) && (count[3] == 5) && (count[4] == 2) && (count[5] != 0)));
        end
        if (reset) begin
            count[0] <= 0;
            count[1] <= 0;
            count[2] <= 0;
            count[3] <= 0;
            count[4] <= 0;
        end
    end
end
always @(posedge clk, posedge reset) begin: CLOCK_TFF
    if (reset == 1) begin
        count[0] <= 0;
        count[1] <= 0;
        count[2] <= 0;
        count[3] <= 0;
        count[4] <= 0;
        count[5] <= 0;
        pm <= 0;
    end
    else begin
        if (en) begin
            count[5] <= ((count[5] != 0) ^ (((count[0] == 9) && (count[1] == 5) && (count[2] == 9) && (count[3] == 5) && (count[4] == 9)) || ((count[0] == 9) && (count[1] == 5) && (count[2] == 9) && (count[3] == 5) && (count[4] == 2) && (count[5] != 0))));
            pm <= (pm ^ ((count[0] == 9) && (count[1] == 5) && (count[2] == 9) && (count[3] == 5) && (count[4] == 1) && (count[5] != 0)));
        end
        if (reset) begin
            count[5] <= 0;
            pm <= 0;
        end
    end
end
always @(count[0], count[1], count[2], count[3], count[4], count[5]) begin: CLOCK_DECODER
    integer i;
    for (i=0; i<6; i=i+1) begin
        LED[i] = {(((count[i][0] && (!count[i][1]) && (!count[i][2]) && (!count[i][3])) || ((!count[i][0]) && (!count[i][1]) && count[i][2]) || (count[i][1] && count[i][3])) != 0), (((count[i][0] && (!count[i][1]) && count[i][2]) || ((!count[i][0]) && count[i][1] && count[i][2]) || (count[i][1] && count[i][3])) != 0), ((((!count[i][0]) && count[i][1] && (!count[i][2])) || (count[i][2] && count[i][3])) != 0), (((count[i][0] && (!count[i][1]) && (!count[i][2]) && (!count[i][3])) || (count[i][0] && count[i][1] && count[i][2]) || ((!count[i][0]) && (!count[i][1]) && count[i][2])) != 0), ((count[i][0] || ((!count[i][1]) && count[i][2])) != 0), (((count[i][0] && (!count[i][2]) && (!count[i][3])) || (count[i][0] && count[i][1]) || (count[i][1] && (!count[i][2]))) != 0), (((count[i][0] && count[i][1] && count[i][2]) || ((!count[i][1]) && (!count[i][2]) && (!count[i][3]))) != 0)};
    end
    if ((!(count[5] != 0))) begin
        LED[5] = 127;
    end
end
endmodule