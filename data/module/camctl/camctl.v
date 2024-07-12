module camctl
  ( input       clk            ,  
    input       rst            ,  
    input       wEnb           ,  
    input       oldPattV       ,  
    input       oldPattMultiOcc,  
    input       newPattMultiOcc,  
    input oldEqNewPatt,
    output reg  wEnb_setram    ,  
    output reg  wEnb_idxram    ,  
    output reg  wEnb_vacram    ,  
    output reg  wEnb_indc      ,  
    output reg  wEnb_indx      ,  
    output reg  wEnb_iVld      ,  
    output reg  wIVld          ,  
    output reg  oldNewbPattWr  ); 
  reg [1:0] curStt, nxtStt  ;
  localparam S0 = 2'b00;
  localparam S1 = 2'b01;
  localparam S2 = 2'b10;
  always @(posedge clk, posedge rst)
    if (rst) curStt <= S0    ;
    else     curStt <= nxtStt;
  always @(*) begin
    {wEnb_setram,wEnb_idxram,wEnb_vacram,wEnb_indc,wEnb_indx,wEnb_iVld,wIVld,oldNewbPattWr} = 8'h00;
    case (curStt)
      S0: nxtStt = wEnb?S1:S0; 
      S1: begin 
            nxtStt        = S2                          ;
            wEnb_indc     = !(oldEqNewPatt && oldPattV) && oldPattV &&  oldPattMultiOcc;
            wEnb_iVld     = !(oldEqNewPatt && oldPattV) && oldPattV && !oldPattMultiOcc;
            oldNewbPattWr = oldPattV                    ;
          end
      S2: begin 
            nxtStt        = S0                                                ;
            wEnb_setram   = !(oldEqNewPatt && oldPattV) && 1'b1                                              ;
            wEnb_idxram   = !(oldEqNewPatt && oldPattV) && 1'b1                                  ;
            wEnb_vacram   = !(oldEqNewPatt && oldPattV) && (oldPattV && !oldPattMultiOcc) || !newPattMultiOcc;
            wEnb_indc     = !(oldEqNewPatt && oldPattV) && 1'b1                                              ;
            wEnb_indx     = !(oldEqNewPatt && oldPattV) && !newPattMultiOcc                                  ;
            wEnb_iVld     = !(oldEqNewPatt && oldPattV) && !newPattMultiOcc                                  ;
            wIVld         = 1'b1                                              ;
            oldNewbPattWr = 1'b0                                              ;
          end
    endcase
  end
endmodule