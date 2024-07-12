module mips_cop0    (
                    input clk,
                    input rst,
                    input[4:0]    rd_addr,
                    output[31:0]  rd_data,
                    output[31:0]  rd_epc,
                    output        rd_int,
                    output        rd_status_exl,
                    input[4:0]    wr_addr,
                    input         wr_en,
                    input[31:0]   wr_data,
                    input         wr_status_exl_reset,
                    input         wr_status_exl_set,
                    input         wr_cause_en,
                    input         wr_cause_bd,
                    input[5:0]    wr_cause_int,
                    input[3:0]    wr_cause_excode,
                    input         wr_badvaddr_en,
                    input[31:0]   wr_badvaddr_data
                    );
  reg[31:0]   epc;
  reg[31:0]   badvaddr;
  reg         cause_bd;
  reg[5:0]    cause_ip;
  reg[3:0]    cause_excode;
  reg[5:0]    status_im;
  reg         status_exl;
  reg         status_ie;
  assign rd_epc= epc;
  assign rd_status_exl= status_exl;
  assign rd_data= rd_addr==5'd14 ?  epc :
                  rd_addr==5'd13 ?  {cause_bd,15'd0,
                                    cause_ip,4'd0,
                                    cause_excode,2'd0} :
                  rd_addr==5'd8 ?   badvaddr :
                                    {16'd0,
                                    status_im,
                                    8'd0,
                                    status_exl,
                                    status_ie};
  assign rd_int= |(cause_ip & status_im) & status_ie & !status_exl;
  always @(posedge clk)
  if(rst)
    begin
    epc<= 32'd0;
    cause_bd<= 1'b0;
    cause_ip<= 6'd0;
    cause_excode<= 4'd0;
    status_im<= 6'd0;
    status_exl<= 1'b1;
    status_ie<= 1'b0;
    badvaddr<= 32'd0;
    end
  else
    begin
    epc<= wr_en & wr_addr==5'd14 ? wr_data : epc;
    cause_bd<= wr_cause_en ? wr_cause_bd : cause_bd;
    cause_ip<= wr_cause_int;
    cause_excode<= wr_cause_en ? wr_cause_excode :
                   cause_excode;
    status_im<= wr_en & wr_addr==5'd12 ? wr_data[15:10] : status_im;
    status_exl<= wr_status_exl_reset ? 1'b0 :
                 wr_status_exl_set ? 1'b1 :
                 wr_en & wr_addr==5'd12 ? wr_data[1] : status_exl;
    status_ie<= wr_en & wr_addr==5'd12 ? wr_data[0] : status_ie;
    badvaddr<= wr_badvaddr_en ? wr_badvaddr_data : badvaddr;
    end
endmodule