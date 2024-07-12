module tx_2(output wire ALERT_TransmitSOP_MessageFailed,
    output wire ALERT_TransmitSuccessful,
    output wire MessageID_mismatch,
    output wire SOP_mismatch,
    output wire MessageID_SOP_match,
    output wire [7:0] TRANSMIT_BYTE_COUNT,
    output wire [7:0] TRANSMIT_HEADER_LOW,
    output wire [7:0] TRANSMIT_HEADER_HIGH,
    output wire [7:0] TRANSMIT_DATA_OBJECTS,
    output wire Start_CRCReceiveTimer,
    output wire Stop_CRCReceiverTimer,
    output wire MessageIDCounter,
    output wire MessageID,
    input wire [2:0] TRANSMIT,
    input wire PRL_Rx_Message_Discard,
    input wire Hard_Reset_received,
    input wire Cable_Reset_received,
    input wire RetryCounter,
    input wire CRCReceiveTimer_Timeout,
    input wire GoodCRC_Response_from_PHY,
    input wire Message_discarded_bus_Idle,
    input wire [7:0] TX_BUF_HEADER_BYTE_1,
    input wire [7:0] RX_BUF_HEADER_BYTE_1,
    input wire [7:0] RX_BUF_FRAME_TYPE,
    input wire CLK,
    input wire RESET);
    wire RetryCounter_bigger;
    wire RetryCounter_smaller;
    reg [7:0] CurrentState;
    reg [7:0] NextState;
    reg [8:0] CRCReceive_timer;
    localparam Wait_for_Transmit_Request = 8'b00000001;
    localparam Reset_RetryCounter        = 8'b00000010;
    localparam Construct_Message         = 8'b00000100;
    localparam Wait_for_PHY_response     = 8'b00001000;
    localparam Match_MessageID           = 8'b00010000;
    localparam Check_RetryCounter        = 8'b00100000;
    localparam Report_Failure            = 8'b01000000;
    localparam Report_Success            = 8'b10000000;
    localparam nRetryCounter            = 2'b10; 
    always@( * )
    begin
        NextState = CurrentState;
    case(CurrentState)
        Wait_for_Transmit_Request:
        begin
        if(PRL_Rx_Message_Discard || Hard_Reset_received || Cable_Reset_received) begin NextState = Reset_RetryCounter; end
        end
        Reset_RetryCounter:
        begin
        NextState = Construct_Message;
        end
        Construct_Message:
        begin
        NextState = Wait_for_PHY_response;
        end
        Wait_for_PHY_response:
        begin
        if     (GoodCRC_Response_from_PHY)  NextState = Match_MessageID;
        else if(Message_discarded_bus_Idle || CRCReceiveTimer_Timeout) NextState= Check_RetryCounter;
        end
        Match_MessageID:
        begin
        if(MessageID_mismatch || SOP_mismatch) NextState = Check_RetryCounter;
        else if(MessageID_SOP_match) NextState = Report_Success;
        end
        Check_RetryCounter:
        begin
        if(RetryCounter_bigger) NextState = Report_Failure;
        else if(RetryCounter_smaller) NextState = Construct_Message;
        end 
        Report_Success:
        begin
        NextState = Wait_for_Transmit_Request;
        end
        Report_Failure:
        begin
        NextState = Wait_for_Transmit_Request;
        end
    endcase
    end
    assign TRANSMIT_BYTE_COUNT = CurrentState==0;
    assign TRANSMIT_HEADER_LOW=0;
    assign TRANSMIT_HEADER_HIGH=0;
    assign TRANSMIT_DATA_OBJECTS=0;
    assign Start_CRCReceiveTimer = CurrentState==Wait_for_PHY_response;
    assign Stop_CRCReceiverTimer = CurrentState== Match_MessageID;
    assign MessageIDCounter = CurrentState==Match_MessageID;
    assign MessageID_mismatch = (CurrentState==Match_MessageID) && (TX_BUF_HEADER_BYTE_1 != RX_BUF_HEADER_BYTE_1);
    assign SOP_mismatch = (CurrentState==Match_MessageID) && (TRANSMIT[2:0] != RX_BUF_FRAME_TYPE);
    assign MessageID_SOP_match = !MessageID_mismatch && !SOP_mismatch;
    assign RetryCounter_bigger = RetryCounter>=nRetryCounter && CurrentState==Check_RetryCounter;
    assign RetryCounter_smaller = RetryCounter<nRetryCounter && CurrentState==Check_RetryCounter;
    assign ALERT_TransmitSOP_MessageFailed= CurrentState==Report_Failure;
    assign ALERT_TransmitSuccessful= CurrentState==Report_Success;    
    always@(posedge CLK)
    begin
        if(RESET) CurrentState  <= Wait_for_Transmit_Request;
        else      CurrentState  <= NextState;
    end
endmodule