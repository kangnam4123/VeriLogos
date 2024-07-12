module psramcon_16(input  wire        CLK,
                   input wire        RST_X,
                   input wire [22:0] WADDR, 
                   input wire [22:0] RADDR, 
                   input wire [15:0] D_IN, 
                   input wire        WE, 
                   input wire        RE, 
                   input wire [1:0]  BE, 
                   output wire       BUSY, 
                   output reg [15:0] RDOUT, 
                   output reg        RDOUT_EN, 
                   output wire       MCLK, 
                   output wire       ADV_X, 
                   output reg        CE_X, 
                   output reg        OE_X, 
                   output reg        WE_X, 
                   output reg        LB_X, 
                   output reg        UB_X, 
                   inout wire [15:0] D_OUT, 
                   output reg [22:0] A_OUT);    
    parameter IDLE     = 0;
    parameter W_PHASE0 = 1;
    parameter W_PHASE1 = 2;
    parameter W_PHASE2 = 3;
    parameter W_PHASE3 = 4;
    parameter W_PHASE4 = 5;
    parameter R_PHASE0 = 6;
    parameter R_PHASE1 = 7;
    parameter R_PHASE2 = 8;
    parameter R_PHASE3 = 9;
    parameter R_PHASE4 = 10;
    assign MCLK  = 0;
    assign ADV_X = 0;
    assign BUSY  = (state != IDLE);
    reg [3:0]                     state;
    reg [15:0]                    D_KEPT;
    reg                           write_mode;
    reg                           read_mode;
    always @(negedge CLK) begin
        if (!RST_X) begin
            A_OUT      <= 0;
            D_KEPT     <= 0;
            OE_X       <= 1;
            WE_X       <= 1;
            CE_X       <= 1;
            LB_X       <= 0;
            UB_X       <= 0;
            write_mode <= 0;
            read_mode  <= 0;
            state      <= IDLE;
            RDOUT_EN   <= 0;
        end else begin
            case (state)
              IDLE: begin
                  RDOUT_EN   <= 0;
                  RDOUT      <= 0;
                  read_mode  <= 0;
                  write_mode <= 0;
                  state      <= (WE) ? W_PHASE0 : (RE) ? R_PHASE0 : state;
                  A_OUT      <= (WE) ? WADDR : (RE) ? RADDR : 0;
                  D_KEPT     <= (WE) ? D_IN : 0;
                  LB_X       <= (WE) ? ~BE[0] : 0;
                  UB_X       <= (WE) ? ~BE[1] : 0;
              end
              W_PHASE0: begin
                  CE_X       <= 0;
                  WE_X       <= 0;
                  write_mode <= 1;
                  state      <= W_PHASE1;
              end
              W_PHASE1: begin
                  state      <= W_PHASE2;
              end
              W_PHASE2: begin
                  state      <= W_PHASE3;
              end
              W_PHASE3: begin
                  state      <= W_PHASE4;
              end
              W_PHASE4: begin
                  CE_X       <= 1;
                  WE_X       <= 1;
                  write_mode <= 1;
                  state      <= IDLE;
              end
              R_PHASE0: begin
                  CE_X      <= 0;
                  OE_X      <= 0;
                  read_mode <= 1;
                  state <= R_PHASE1;
              end
              R_PHASE1: begin
                  state <= R_PHASE2;
              end
              R_PHASE2: begin
                  state <= R_PHASE3;
              end
              R_PHASE3: begin
                  state <= R_PHASE4;
              end
              R_PHASE4: begin
                  CE_X      <= 1;
                  OE_X      <= 1;
                  read_mode <= 0;
                  RDOUT_EN  <= 1;
                  RDOUT     <= D_OUT;
                  state     <= IDLE;
              end
            endcase
        end
    end
    assign D_OUT = (write_mode) ? D_KEPT : 16'hzzzz;
endmodule