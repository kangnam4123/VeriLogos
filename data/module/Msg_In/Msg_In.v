module Msg_In(input clk,
              input rst,
              input start,
              input [31:0]msg_in,
              output reg done,
              output reg [511:0]msg_out
    );
reg [9:0]count;
always@(posedge clk or negedge rst) begin
         if(rst == 0) begin
            done <= 0;
            msg_out <= 0;
            count <= 0;
         end else begin
          if(start)
              if(count < 17)
                count <= count + 1;
         end
end
always@(count) begin
    if(count == 1) 
        msg_out[511:480] = msg_in;
    else if(count == 2)
        msg_out[479:448] = msg_in;
    else if(count == 3)
        msg_out[447:416] = msg_in;
    else if(count == 4)
        msg_out[415:384] = msg_in;
    else if(count == 5)
        msg_out[383:352] = msg_in;
    else if (count == 6) 
        msg_out[351:320] = msg_in;
    else if (count == 7) 
        msg_out[319:288] = msg_in;
    else if (count == 8) 
        msg_out[287:256] = msg_in;   
    else if (count == 9) 
        msg_out[255:224] = msg_in;                 
    else if (count == 10) 
        msg_out[223:192] = msg_in;                 
    else if (count == 11) 
        msg_out[191:160] = msg_in;                 
    else if (count == 12) 
        msg_out[159:128] = msg_in;                 
    else if (count == 13) 
        msg_out[127:96] = msg_in;
    else if (count == 14) 
        msg_out[95:64] = msg_in;                 
    else if (count == 15) 
        msg_out[63:32] = msg_in;
    else if (count == 16) 
        msg_out[31:0] = msg_in;                 
    else if (count == 17)
        done = 1;
    else begin end
end
endmodule