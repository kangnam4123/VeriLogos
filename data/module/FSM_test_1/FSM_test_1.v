module FSM_test_1
(
input wire clk,
input wire rst,
input wire ready_op,
input wire max_tick_address,
input wire max_tick_ch,
input wire TX_DONE,
output reg beg_op,
output reg ack_op,
output reg load_address,
output reg enab_address,
output reg enab_ch,
output reg load_ch,
output reg TX_START
);
localparam [3:0]    est0 = 4'b0000,
                    est1 = 4'b0001,
                    est2 = 4'b0010,
                    est3 = 4'b0011,
                    est4 = 4'b0100,
                    est5 = 4'b0101, 
                    est6 = 4'b0110,
                    est7 = 4'b0111,
                    est8 = 4'b1000,
                    est9 = 4'b1001,
                    est10 = 4'b1010,
                    est11 = 4'b1011;
reg [3:0] state_reg, state_next;    
always @( posedge clk, posedge rst)
    begin
        if(rst)	
            state_reg <= est0;
        else		
            state_reg <= state_next;
    end
always @*
    begin
        state_next = state_reg; 
        beg_op = 1'b0;
        ack_op = 1'b0;
        load_address = 1'b0;
        enab_address = 1'b0;
        enab_ch = 1'b0;
        load_ch = 1'b0;
        TX_START = 1'b0;
        case(state_reg)
        est0:
            begin
                state_next = est1;
            end
        est1:
            begin
                load_address = 1'b1;
                enab_address = 1'b1;
                state_next = est2;
            end
        est2:
            begin
                beg_op = 1'b1;
                state_next=est3;
            end
        est3:
            begin
                beg_op = 1'b1;
                enab_ch = 1'b1;
                load_ch = 1'b1;
                state_next=est4;
            end
        est4:
            begin
                if(ready_op)
                    state_next=est5;
                else
                    state_next=est4;
            end
        est5:
            begin
                state_next=est6;
            end
        est6:
            begin
                TX_START = 1'b1;
                state_next=est7;
            end
        est7:
            begin
                if(TX_DONE)
                    if(max_tick_ch)
                        state_next=est9;
                    else
                        begin
                            state_next=est8;
                        end
                else
                    state_next=est7;
            end
        est8:
            begin
                enab_ch = 1'b1;
                state_next=est5;
            end
        est9:
            begin
                if(max_tick_address)
                    state_next=est11;
                else
                    begin
                        state_next=est10;
                    end
            end
        est10:
            begin
                enab_address = 1'b1;
                ack_op = 1'b1;
                state_next=est2;
            end
        est11:
            begin
                state_next=est11;
            end
        default:
            state_next=est0;
        endcase
    end
endmodule