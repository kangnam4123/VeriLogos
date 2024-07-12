module EXMEM_Stage(
    input  clock,
    input  reset,
    input  EX_Flush,
    input  EX_Stall,
    input  M_Stall,
    input  EX_Movn,
    input  EX_Movz,
    input  EX_BZero,
    input  EX_RegWrite,  
    input  EX_MemtoReg,  
    input  EX_ReverseEndian,
    input  EX_LLSC,
    input  EX_MemRead,
    input  EX_MemWrite,
    input  EX_MemByte,
    input  EX_MemHalf,
    input  EX_MemSignExtend,
    input  EX_Left,
    input  EX_Right,
    input  EX_KernelMode,
    input  [31:0] EX_RestartPC,
    input  EX_IsBDS,
    input  EX_Trap,
    input  EX_TrapCond,
    input  EX_M_CanErr,
    input  [31:0] EX_ALU_Result,
    input  [31:0] EX_ReadData2,
    input  [4:0]  EX_RtRd,
    input M_RegWrite,
    input M_MemtoReg,
    input M_ReverseEndian,
    input M_LLSC,
    input M_MemRead,
    input M_MemWrite,
    input M_MemByte,
    input M_MemHalf,
    input M_MemSignExtend,
    input M_Left,
    input M_Right,
    input M_KernelMode,
    input [31:0] M_RestartPC,
    input M_IsBDS,
    input M_Trap,
    input M_TrapCond,
    input M_M_CanErr,
    input [31:0] M_ALU_Result,
    input [31:0] M_ReadData2,
    input [4:0]  M_RtRd,
	 output reg vote_M_RegWrite,
    output reg vote_M_MemtoReg,
    output reg vote_M_ReverseEndian,
    output reg vote_M_LLSC,
    output reg vote_M_MemRead,
    output reg vote_M_MemWrite,
    output reg vote_M_MemByte,
    output reg vote_M_MemHalf,
    output reg vote_M_MemSignExtend,
    output reg vote_M_Left,
    output reg vote_M_Right,
    output reg vote_M_KernelMode,
    output reg [31:0] vote_M_RestartPC,
    output reg vote_M_IsBDS,
    output reg vote_M_Trap,
    output reg vote_M_TrapCond,
    output reg vote_M_M_CanErr,
    output reg [31:0] vote_M_ALU_Result,
    output reg [31:0] vote_M_ReadData2,
    output reg [4:0]  vote_M_RtRd
    );
    wire MovcRegWrite = (EX_Movn & ~EX_BZero) | (EX_Movz & EX_BZero);
    always @(posedge clock) begin
        vote_M_RegWrite      <= (reset) ? 1'b0  : ((M_Stall) ? M_RegWrite      : ((EX_Stall | EX_Flush) ? 1'b0 : ((EX_Movn | EX_Movz) ? MovcRegWrite : EX_RegWrite)));
        vote_M_MemtoReg      <= (reset) ? 1'b0  : ((M_Stall) ? M_MemtoReg                                      : EX_MemtoReg);
        vote_M_ReverseEndian <= (reset) ? 1'b0  : ((M_Stall) ? M_ReverseEndian                                 : EX_ReverseEndian);
        vote_M_LLSC          <= (reset) ? 1'b0  : ((M_Stall) ? M_LLSC                                          : EX_LLSC);
        vote_M_MemRead       <= (reset) ? 1'b0  : ((M_Stall) ? M_MemRead       : ((EX_Stall | EX_Flush) ? 1'b0 : EX_MemRead));
        vote_M_MemWrite      <= (reset) ? 1'b0  : ((M_Stall) ? M_MemWrite      : ((EX_Stall | EX_Flush) ? 1'b0 : EX_MemWrite));
        vote_M_MemByte       <= (reset) ? 1'b0  : ((M_Stall) ? M_MemByte                                       : EX_MemByte);
        vote_M_MemHalf       <= (reset) ? 1'b0  : ((M_Stall) ? M_MemHalf                                       : EX_MemHalf);
        vote_M_MemSignExtend <= (reset) ? 1'b0  : ((M_Stall) ? M_MemSignExtend                                 : EX_MemSignExtend);
        vote_M_Left          <= (reset) ? 1'b0  : ((M_Stall) ? M_Left                                          : EX_Left);
        vote_M_Right         <= (reset) ? 1'b0  : ((M_Stall) ? M_Right                                         : EX_Right);
        vote_M_KernelMode    <= (reset) ? 1'b0  : ((M_Stall) ? M_KernelMode                                    : EX_KernelMode);
        vote_M_RestartPC     <= (reset) ? 32'b0 : ((M_Stall) ? M_RestartPC                                     : EX_RestartPC);
        vote_M_IsBDS         <= (reset) ? 1'b0  : ((M_Stall) ? M_IsBDS                                         : EX_IsBDS);
        vote_M_Trap          <= (reset) ? 1'b0  : ((M_Stall) ? M_Trap          : ((EX_Stall | EX_Flush) ? 1'b0 : EX_Trap));
        vote_M_TrapCond      <= (reset) ? 1'b0  : ((M_Stall) ? M_TrapCond                                      : EX_TrapCond);
        vote_M_M_CanErr      <= (reset) ? 1'b0  : ((M_Stall) ? M_M_CanErr      : ((EX_Stall | EX_Flush) ? 1'b0 : EX_M_CanErr));
        vote_M_ALU_Result    <= (reset) ? 32'b0 : ((M_Stall) ? M_ALU_Result                                    : EX_ALU_Result);
        vote_M_ReadData2     <= (reset) ? 32'b0 : ((M_Stall) ? M_ReadData2                                     : EX_ReadData2);
        vote_M_RtRd          <= (reset) ? 5'b0  : ((M_Stall) ? M_RtRd                                          : EX_RtRd);
    end
endmodule