module DebugIR (
    input wire clk,
    input wire rst,
    input wire ir,
    output reg[3:0] mode,
    output reg showName,
    output reg err,
    output wire stateOut,
    output reg[1:0] cpuClkMode,
    output reg[3:0] numberPressedData,
    output reg numberPressed
    );
reg[31:0] irRead; 
reg[5:0] irDataPos; 
reg ir0, ir1, ir2; 
always @(posedge clk) begin
    if (rst) begin
        ir0 <= 1'b0;
        ir1 <= 1'b0;
        ir2 <= 1'b0;
    end
    else begin
        ir0 <= ir;
        ir1 <= ir0;
        ir2 <= ir1;
    end
end
wire irPosEdge = !ir2 && ir1;
wire irNegEdge = ir2 && !ir1;
wire irChange = irPosEdge || irNegEdge;
reg[10:0] counter1; 
reg[8:0] counter2; 
always @(posedge clk) begin
    if (rst)
        counter1 <= 11'b0;
    else if (irChange)
        counter1 <= 11'b0;
    else if (counter1 == 11'd1750)
        counter1 <= 11'b0;
    else
        counter1 <= counter1 + 11'b1;
end
always @(posedge clk) begin
    if (rst)
        counter2 <= 9'b0;
    else if (irChange)
        counter2 <= 9'b0;
    else if (counter1 == 11'd1750)
        counter2 <= counter2 + 9'b1;
end
wire check9ms = (217 < counter2) && (counter2 < 297); 
wire check4ms = (88 < counter2)  && (counter2 < 168); 
wire high     = (6 < counter2)   && (counter2 < 26);  
wire low      = (38 < counter2)  && (counter2 < 58);  
parameter   CHANNEL_MINUS = 8'hA2,
            CHANNEL = 8'h62,
            CHANNEL_PLUS = 8'hE2,
            PLAY = 8'hC2,
            EQ = 8'h90,
            N0 = 8'h68,
            N1 = 8'h30,
            N2 = 8'h18,
            N3 = 8'h7A,
            N4 = 8'h10,
            N5 = 8'h38,
            N6 = 8'h5A,
            N7 = 8'h42,
            N8 = 8'h4A,
            N9 = 8'h52;
parameter   IDLE = 3'b000,
            LEADING_9MS = 3'b001,
            LEADING_4MS = 3'b010,
            DATA_READ   = 3'b100;
reg[2:0] state;
reg[2:0] nextState;
always @(posedge clk) begin
    if (rst)
        state <= IDLE;
    else
        state <= nextState;
end
always @(*) begin
    case (state)
        IDLE:
            if (ir1)
                nextState = LEADING_9MS;
            else
                nextState = IDLE;
        LEADING_9MS:
            if (irNegEdge) begin
                if (check9ms)
                    nextState = LEADING_4MS;
                else
                    nextState = IDLE;
            end else
                nextState = LEADING_9MS;
        LEADING_4MS:
            if (irPosEdge) begin
                if (check4ms)
                    nextState = DATA_READ;
                else
                    nextState = IDLE;
            end else
                nextState = LEADING_4MS;
        DATA_READ:
            if ((irDataPos == 6'd32) && !ir2 && !ir1)
                nextState = IDLE;
            else if (err)
                nextState = IDLE;
            else
                nextState = DATA_READ;
    endcase
end
always @(posedge clk) begin
    if (rst) begin
        irDataPos <= 6'b0;
        irRead <= 32'b0;
        err <= 1'b0;
    end
    else if (state == IDLE) begin
        irDataPos <= 6'b0;
        irRead <= 32'b0;
        err <= 1'b0;
    end
    else if (state == DATA_READ) begin
        if (irNegEdge) begin
            if (!high)
                err <= 1'b1;
        end else if (irPosEdge) begin
            if (high)
                irRead[0] <= 1'b0;
            else if (low)
                irRead[0] <= 1'b1;
            else
                err <= 1'b1;
            irRead[31:1] <= irRead[30:0];
            irDataPos <= irDataPos + 6'b1;
        end
    end
end
always @(posedge clk) begin
    if (rst) begin
        showName <= 1'b0;
        mode <= 4'b0;
        cpuClkMode <= 2'd0;
        numberPressed <= 0;
        numberPressedData <= 4'd0;
    end else if ((irDataPos == 6'd32) && !ir1 && ir2) begin
        case (irRead[15:8])
            CHANNEL:
                showName <= !showName;
            CHANNEL_PLUS:
                if (mode < 4'd13)
                    mode <= mode + 1;
                else
                    mode <= 4'd0;
            CHANNEL_MINUS:
                if (mode > 4'd0)
                    mode <= mode - 1;
                else
                    mode <= 4'd13;
            PLAY:
                cpuClkMode <= cpuClkMode ^ 2'b10;
            EQ:
                cpuClkMode <= cpuClkMode ^ 2'b01;
            N0: begin
                numberPressed <= 1;
                numberPressedData <= 4'd0;
            end
            N1: begin
                numberPressed <= 1;
                numberPressedData <= 4'd1;
            end
            N2: begin
                numberPressed <= 1;
                numberPressedData <= 4'd2;
            end
            N3: begin
                numberPressed <= 1;
                numberPressedData <= 4'd3;
            end
            N4: begin
                numberPressed <= 1;
                numberPressedData <= 4'd4;
            end
            N5: begin
                numberPressed <= 1;
                numberPressedData <= 4'd5;
            end
            N6: begin
                numberPressed <= 1;
                numberPressedData <= 4'd6;
            end
            N7: begin
                numberPressed <= 1;
                numberPressedData <= 4'd7;
            end
            N8: begin
                numberPressed <= 1;
                numberPressedData <= 4'd8;
            end
            N9: begin
                numberPressed <= 1;
                numberPressedData <= 4'd9;
            end
        endcase
    end
    if (numberPressed)
        numberPressed <= 0;
end
assign stateOut = (irDataPos == 6'd32) && (!ir2) && (!ir1);
endmodule