module hdUnit(
  d_raddr1, d_raddr2, d_addrselector, d_jr_or_exec, d_immonly, d_opcode, e_isLoad, e_wreg, 
  pc_stall, ifid_stall, idex_stall, inst_stall,
  write_done
);
input [3:0] d_raddr1;
input [3:0] d_raddr2;
input d_addrselector;
input d_jr_or_exec;
input d_immonly;
input [3:0] d_opcode;
input e_isLoad;
input [3:0] e_wreg;
input write_done;
output pc_stall;
output ifid_stall; 
output idex_stall;
output inst_stall;
assign pc_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) ||
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec===1'b1 && (d_raddr2===e_wreg)) || 
(d_opcode!==4'b1000 && d_addrselector!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) || 
(d_opcode===4'b1000 && d_addrselector!==1'b1 && d_raddr1===e_wreg) 
)) ? 1'b1 : 1'b0;
assign ifid_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) ||
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec===1'b1 && (d_raddr2===e_wreg)) || 
(d_opcode!==4'b1000 && d_opcode!==4'b1000 && d_addrselector!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) || 
(d_opcode===4'b1000 && d_addrselector!==1'b1 && d_raddr1===e_wreg) 
)) ? 1'b1 : 1'b0;
assign idex_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) ||
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec===1'b1 && (d_raddr2===e_wreg)) || 
(d_opcode!==4'b1000 && d_addrselector!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) || 
(d_opcode===4'b1000 && d_addrselector!==1'b1 && d_raddr1===e_wreg) 
)) ? 1'b1 : 1'b0;
assign inst_stall = (write_done === 1'b1)? 1'b0 :(e_isLoad===1'b1 && d_immonly!==1'b1 && e_wreg!==4'b000 && (
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) ||
(d_opcode!==4'b1000 && d_addrselector===1'b1 && d_jr_or_exec===1'b1 && (d_raddr2===e_wreg)) || 
(d_opcode!==4'b1000 && d_addrselector!==1'b1 && (d_raddr1===e_wreg || d_raddr2===e_wreg)) || 
(d_opcode===4'b1000 && d_addrselector!==1'b1 && d_raddr1===e_wreg) 
)) ? 1'b1 : 1'b0;
endmodule