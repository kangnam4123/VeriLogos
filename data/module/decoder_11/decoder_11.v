module decoder_11(
  clock, execute, opcode,
  wrtrigmask, wrtrigval, wrtrigcfg,
  wrspeed, wrsize, wrFlags,
  wrTrigSelect, wrTrigChain,
  finish_now,
  arm_basic, arm_adv, resetCmd);
input clock;
input execute;
input [7:0] opcode;
output [3:0] wrtrigmask;
output [3:0] wrtrigval;
output [3:0] wrtrigcfg;
output wrspeed;
output wrsize;
output wrFlags;
output wrTrigSelect;
output wrTrigChain;
output finish_now;
output arm_basic;
output arm_adv;
output resetCmd;
reg resetCmd, next_resetCmd;
reg arm_basic, next_arm_basic;
reg arm_adv, next_arm_adv;
reg [3:0] wrtrigmask, next_wrtrigmask;
reg [3:0] wrtrigval, next_wrtrigval;
reg [3:0] wrtrigcfg, next_wrtrigcfg;
reg wrspeed, next_wrspeed;
reg wrsize, next_wrsize;
reg wrFlags, next_wrFlags;
reg finish_now, next_finish_now;
reg wrTrigSelect, next_wrTrigSelect;
reg wrTrigChain, next_wrTrigChain;
reg dly_execute, next_dly_execute;
always @(posedge clock) 
begin
  resetCmd = next_resetCmd;
  arm_basic = next_arm_basic;
  arm_adv = next_arm_adv;
  wrtrigmask = next_wrtrigmask;
  wrtrigval = next_wrtrigval;
  wrtrigcfg = next_wrtrigcfg;
  wrspeed = next_wrspeed;
  wrsize = next_wrsize;
  wrFlags = next_wrFlags;
  finish_now = next_finish_now;
  wrTrigSelect = next_wrTrigSelect;
  wrTrigChain = next_wrTrigChain;
  dly_execute = next_dly_execute;
end
always @*
begin
  #1;
  next_resetCmd = 1'b0;
  next_arm_basic = 1'b0;
  next_arm_adv = 1'b0;
  next_wrtrigmask = 4'b0000;
  next_wrtrigval = 4'b0000;
  next_wrtrigcfg = 4'b0000;
  next_wrspeed = 1'b0;
  next_wrsize = 1'b0;
  next_wrFlags = 1'b0;
  next_finish_now = 1'b0;
  next_wrTrigSelect = 1'b0;
  next_wrTrigChain = 1'b0;
  next_dly_execute = execute;
  if (execute & !dly_execute)
    case(opcode)
      8'h00 : next_resetCmd = 1'b1;
      8'h01 : next_arm_basic = 1'b1;
      8'h02 :;
      8'h03 :;
      8'h04 :;
      8'h05 : next_finish_now = 1'b1;
      8'h06 :;
      8'h0F : next_arm_adv = 1'b1;
      8'h11 :;
      8'h13 :;
      8'h80 : next_wrspeed = 1'b1;
      8'h81 : next_wrsize = 1'b1;
      8'h82 : next_wrFlags = 1'b1;
      8'h9E : next_wrTrigSelect = 1'b1;
      8'h9F : next_wrTrigChain = 1'b1;
      8'hC0 : next_wrtrigmask[0] = 1'b1;
      8'hC1 : next_wrtrigval[0] = 1'b1;
      8'hC2 : next_wrtrigcfg[0] = 1'b1;
      8'hC4 : next_wrtrigmask[1] = 1'b1;
      8'hC5 : next_wrtrigval[1] = 1'b1;
      8'hC6 : next_wrtrigcfg[1] = 1'b1;
      8'hC8 : next_wrtrigmask[2] = 1'b1;
      8'hC9 : next_wrtrigval[2] = 1'b1;
      8'hCA : next_wrtrigcfg[2] = 1'b1;
      8'hCC : next_wrtrigmask[3] = 1'b1;
      8'hCD : next_wrtrigval[3] = 1'b1;
      8'hCE : next_wrtrigcfg[3] = 1'b1;
    endcase
end
endmodule