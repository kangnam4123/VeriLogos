module Operate
  (clk, reset, start, ack, instruc, rdData,
   rdEn, wrEn, addr, wrData, pc, done);
  localparam INSTRUC_SIZE = 32, ARG_SIZE = 8, DATA_SIZE = 8,
             OP_ADD = 8'h0, OP_SUB = 8'h1, OP_RSHIFT = 8'h2, OP_LSHIFT = 8'h3,
             OP_AND = 8'h4, OP_OR = 8'h5, OP_XOR = 8'h6, OP_INV = 8'h7,
             OP_JMP = 8'h8, OP_JEQ0 = 8'h9, OP_JGT0 = 8'hA, OP_JLT0 = 8'hB,
             OP_LDC = 8'hC, OP_COPY = 8'hD, OP_HALT = 8'hF,
             INIT = 3'd0, FETCH = 3'd1, RD_DATA2 = 3'd2, RD_DATA3 = 3'd3, RD_DATA_FINISH = 3'd4, OPERATE = 3'd5, DONE = 3'd6;
  input clk, reset, start, ack;
  input [(INSTRUC_SIZE - 1) : 0] instruc;
  input [(DATA_SIZE - 1) : 0] rdData;
  output reg rdEn; 
  output reg wrEn; 
  output reg [(ARG_SIZE - 1) : 0] addr; 
  output reg [(DATA_SIZE - 1) : 0] wrData; 
  output reg [(ARG_SIZE - 1) : 0] pc; 
  output wire done;
  reg [2:0] state;
  assign done = (state == DONE);
  always @(posedge clk, posedge reset)
  begin
    rdEn <= 1'b0;
    wrEn <= 1'b0;
    addr <= 8'bx;
    wrData <= 8'bx;
    if (reset)
    begin
      state <= INIT;
    end
    else
    begin : OPERATE_BLOCK
      reg [(ARG_SIZE - 1) : 0] opCode, arg1, arg2, arg3;
      reg [(DATA_SIZE - 1) : 0] argData2, argData3; 
      opCode = instruc[31:24];
      arg1 = instruc[23:16];
      arg2 = instruc[15:8];
      arg3 = instruc[7:0];
      case (state)
        INIT:
        begin
          if (start) state <= FETCH;
          pc <= 1'b0;
        end
        FETCH:
        begin
          state <= RD_DATA2;
          argData2 <= 8'bx;
          argData3 <= 8'bx;
        end
        RD_DATA2:
        begin
          if (opCode == OP_JMP || opCode == OP_LDC || opCode == OP_HALT)
            state <= OPERATE;
          else if (opCode >= OP_INV)
            state <= RD_DATA_FINISH;
          else
            state <= RD_DATA3;
          rdEn <= 1'b1;
          addr <= arg2;
        end
        RD_DATA3:
        begin
          state <= RD_DATA_FINISH;
          rdEn <= 1'b1;
          addr <= arg3;
        end
        RD_DATA_FINISH:
        begin
          state <= OPERATE;
          argData2 = rdData;
        end
        OPERATE:
        begin
          state <= FETCH;
          if (opCode >= OP_INV)
            argData2 = rdData;
          else
            argData3 = rdData;
          wrEn <= 1'b1;
          addr <= arg1;
          wrData <= 8'bx;
          pc <= pc + 1'b1;
          case (opCode)
            OP_ADD:
            begin
              wrData <= argData2 + argData3;
            end
            OP_SUB:
            begin
              wrData <= argData2 - argData3;
            end
            OP_RSHIFT:
            begin
              wrData <= argData2 >> argData3;
            end
            OP_LSHIFT:
            begin
              wrData <= argData2 << argData3;
            end
            OP_AND:
            begin
              wrData <= argData2 & argData3;
            end
            OP_OR:
            begin
              wrData <= argData2 | argData3;
            end
            OP_XOR:
            begin
              wrData <= argData2 ^ argData3;
            end
            OP_INV:
            begin
              wrData <= ~argData2;
            end
            OP_JMP:
            begin
              wrEn <= 1'b0;
              pc <= arg1;
            end
            OP_JEQ0:
            begin
              wrEn <= 1'b0;
              if (argData2 == 0) pc <= arg1;
            end
            OP_JGT0:
            begin
              wrEn <= 1'b0;
              if (argData2 != 0 && argData2[DATA_SIZE - 1] == 1'b0) pc <= arg1;
            end
            OP_JLT0:
            begin
              wrEn <= 1'b0;
              if (argData2[DATA_SIZE - 1] == 1'b1) pc <= arg1;
            end
            OP_LDC:
            begin
              wrData <= arg2;
            end
            OP_COPY:
            begin
              wrData <= argData2;
            end
            OP_HALT:
            begin
              state <= DONE;
            end
          endcase
        end
        DONE:
        begin
          if (ack) state <= INIT;
        end
      endcase
    end
  end
endmodule