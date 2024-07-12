module NPCG_Toggle_bCMD_manager
#
(
    parameter NumberOfWays    =   4
)
(
    iSystemClock        ,
    iReset              ,
    iTargetWay          ,
    ibCMDStart          ,
    ibCMDLast           ,
    ibCMDLast_SCC       ,
    iNANDPOE            ,
    iCMDHold            ,
    iOpcode             ,
    iTargetID           ,
    iSourceID           ,
    oOpcode_out         ,
    oTargetID_out       ,
    oSourceID_out       ,
    iCMDValid_in        ,
    oCMDValid_out_NPOE  ,
    oCMDValid_out       ,
    oCMDReady_out       ,
    iCMDReady_in        ,
    oWorkingWay    
);
    input                           iSystemClock            ;
    input                           iReset                  ;
    input   [NumberOfWays - 1:0]    iTargetWay              ;
    input                           ibCMDStart              ;
    input                           ibCMDLast               ;
    input                           ibCMDLast_SCC           ;
    input                           iNANDPOE                ;
    input                           iCMDHold                ;
    input   [5:0]                   iOpcode                 ;
    input   [4:0]                   iTargetID               ;
    input   [4:0]                   iSourceID               ;
    output  [5:0]                   oOpcode_out             ;
    output  [4:0]                   oTargetID_out           ;
    output  [4:0]                   oSourceID_out           ;
    input                           iCMDValid_in            ;
    output                          oCMDValid_out_NPOE      ;
    output                          oCMDValid_out           ;
    output                          oCMDReady_out           ;
    input                           iCMDReady_in            ;
    output  [NumberOfWays - 1:0]    oWorkingWay             ;
    parameter MNG_FSM_BIT = 5; 
    parameter MNG_RESET = 5'b00001;
    parameter MNG_READY = 5'b00010; 
    parameter MNG_START = 5'b00100; 
    parameter MNG_RUNNG = 5'b01000; 
    parameter MNG_bH_Zd = 5'b10000; 
    reg     [MNG_FSM_BIT-1:0]       rMNG_cur_state          ;
    reg     [MNG_FSM_BIT-1:0]       rMNG_nxt_state          ;
    reg     [3:0]                   rbH_ZdCounter           ;
    wire                            wbH_ZdDone              ;
    reg     [NumberOfWays - 1:0]    rWorkingWay             ;
    reg                             rCMDBlocking            ;
    assign wbH_ZdDone = (rbH_ZdCounter[3:0] == 4'b0100);
    always @ (posedge iSystemClock, posedge iReset) begin
        if (iReset) begin
            rMNG_cur_state <= MNG_RESET;
        end else begin
            rMNG_cur_state <= rMNG_nxt_state;
        end
    end
    always @ ( * ) begin
        case (rMNG_cur_state)
            MNG_RESET: begin
                rMNG_nxt_state <= MNG_READY;
            end
            MNG_READY: begin
                rMNG_nxt_state <= (ibCMDStart)? MNG_START:MNG_READY;
            end
            MNG_START: begin
                rMNG_nxt_state <= (ibCMDLast)? ((ibCMDLast_SCC)? MNG_READY:MNG_bH_Zd):MNG_RUNNG;
            end
            MNG_RUNNG: begin
                rMNG_nxt_state <= (ibCMDLast)? ((ibCMDLast_SCC)? MNG_READY:MNG_bH_Zd):MNG_RUNNG;
            end
            MNG_bH_Zd: begin
                rMNG_nxt_state <= (wbH_ZdDone)? MNG_READY:MNG_bH_Zd;
            end
            default:
                rMNG_nxt_state <= MNG_READY;
        endcase
    end
    always @ (posedge iSystemClock, posedge iReset) begin
        if (iReset) begin
            rWorkingWay[NumberOfWays - 1:0] <= 0;
            rCMDBlocking                    <= 0;
            rbH_ZdCounter[3:0]              <= 0;
        end else begin
            case (rMNG_nxt_state)
                MNG_RESET: begin
                    rWorkingWay[NumberOfWays - 1:0] <= 0;
                    rCMDBlocking                    <= 0;
                    rbH_ZdCounter[3:0]              <= 0;
                end
                MNG_READY: begin
                    rWorkingWay[NumberOfWays - 1:0] <= 0;
                    rCMDBlocking                    <= 0;
                    rbH_ZdCounter[3:0]              <= 0;
                end
                MNG_START: begin
                    rWorkingWay[NumberOfWays - 1:0] <= iTargetWay[NumberOfWays - 1:0];
                    rCMDBlocking                    <= 1'b1;
                    rbH_ZdCounter[3:0]              <= 4'b0000;
                end
                MNG_RUNNG: begin
                    rWorkingWay[NumberOfWays - 1:0] <= rWorkingWay[NumberOfWays - 1:0];
                    rCMDBlocking                    <= 1'b1;
                    rbH_ZdCounter[3:0]              <= 4'b0000;
                end
                MNG_bH_Zd: begin
                    rWorkingWay[NumberOfWays - 1:0] <= rWorkingWay[NumberOfWays - 1:0];
                    rCMDBlocking                    <= 1'b1;
                    rbH_ZdCounter[3:0]              <= rbH_ZdCounter[3:0] + 1'b1;
                end
            endcase
        end
    end
    assign oCMDValid_out_NPOE   = (~rCMDBlocking) & (iNANDPOE | (iCMDValid_in & (~iNANDPOE)));
    assign oCMDValid_out        = (~rCMDBlocking) & (~iCMDHold) & (iCMDValid_in) & (~iNANDPOE);
    assign oCMDReady_out        = (~rCMDBlocking) & (~iCMDHold) & (iCMDReady_in) & (~iNANDPOE);
    assign oOpcode_out[5:0] = (iNANDPOE)? (6'b111110):(iOpcode[5:0]);
    assign oTargetID_out[4:0] = (iNANDPOE)? (5'b00101):(iTargetID[4:0]);
    assign oSourceID_out[4:0] = (iNANDPOE)? (5'b00101):(iSourceID[4:0]);
    assign oWorkingWay[NumberOfWays - 1:0] = rWorkingWay[NumberOfWays - 1:0];
endmodule