module NPM_Toggle_IDLE_DDR100
#
(
    parameter NumberOfWays    =   4
)
(
    iNANDPowerOnEvent       ,
    oPI_Reset               ,
    oPI_BUFF_Reset          ,
    oPO_Reset               ,
    oPI_BUFF_RE             ,
    oPI_BUFF_WE             ,
    oPI_BUFF_OutSel         ,
    oPIDelayTapLoad         ,
    oPIDelayTap             ,
    oPO_DQStrobe            ,
    oPO_DQ                  ,
    oPO_ChipEnable          ,
    oPO_ReadEnable          ,
    oPO_WriteEnable         ,
    oPO_AddressLatchEnable  ,
    oPO_CommandLatchEnable  ,
    oDQSOutEnable           ,
    oDQOutEnable            
);
    input                           iNANDPowerOnEvent       ;
    output                          oPI_Reset               ;
    output                          oPI_BUFF_Reset          ;
    output                          oPO_Reset               ;
    output                          oPI_BUFF_RE             ;
    output                          oPI_BUFF_WE             ;
    output  [2:0]                   oPI_BUFF_OutSel         ;
    output                          oPIDelayTapLoad         ;
    output  [4:0]                   oPIDelayTap             ;
    output  [7:0]                   oPO_DQStrobe            ;
    output  [31:0]                  oPO_DQ                  ;
    output  [2*NumberOfWays - 1:0]  oPO_ChipEnable          ;
    output  [3:0]                   oPO_ReadEnable          ;
    output  [3:0]                   oPO_WriteEnable         ;
    output  [3:0]                   oPO_AddressLatchEnable  ;
    output  [3:0]                   oPO_CommandLatchEnable  ;
    output                          oDQSOutEnable           ;
    output                          oDQOutEnable            ;
    assign oPI_Reset = (iNANDPowerOnEvent)? 1'b1:1'b0;
    assign oPI_BUFF_Reset = 0;
    assign oPO_Reset = (iNANDPowerOnEvent)? 1'b1:1'b0;
    assign oPI_BUFF_RE = 0;
    assign oPI_BUFF_WE = 0;
    assign oPI_BUFF_OutSel[2:0] = 3'b000;
    assign oPIDelayTapLoad = 0;
    assign oPIDelayTap[4:0] = 5'b11100; 
    assign oPO_DQStrobe[7:0] = 8'b1111_1111;
    assign oPO_DQ[31:0] = 0;
    assign oPO_ChipEnable = 0;
    assign oPO_ReadEnable[3:0] = 0;
    assign oPO_WriteEnable[3:0] = 0;
    assign oPO_AddressLatchEnable[3:0] = 0;
    assign oPO_CommandLatchEnable[3:0] = 0;
    assign oDQSOutEnable = 0;
    assign oDQOutEnable = 0;
endmodule