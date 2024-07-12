module fmrv32im_BADMEM_sel
  (
   output        D_MEM_WAIT,
   input         D_MEM_ENA,
   input [3:0]   D_MEM_WSTB,
   input [31:0]  D_MEM_ADDR,
   input [31:0]  D_MEM_WDATA,
   output [31:0] D_MEM_RDATA,
   output        D_MEM_BADMEM_EXCPT,
   input         C_MEM_WAIT,
   output        C_MEM_ENA,
   output [3:0]  C_MEM_WSTB,
   output [31:0] C_MEM_ADDR,
   output [31:0] C_MEM_WDATA,
   input [31:0]  C_MEM_RDATA,
   input         C_MEM_BADMEM_EXCPT,
   input         PERIPHERAL_BUS_WAIT,
   output        PERIPHERAL_BUS_ENA,
   output [3:0]  PERIPHERAL_BUS_WSTB,
   output [31:0] PERIPHERAL_BUS_ADDR,
   output [31:0] PERIPHERAL_BUS_WDATA,
   input [31:0]  PERIPHERAL_BUS_RDATA,
   output        PLIC_BUS_WE,
   output [3:0]  PLIC_BUS_ADDR,
   output [31:0] PLIC_BUS_WDATA,
   input [31:0]  PLIC_BUS_RDATA,
   output        TIMER_BUS_WE,
   output [3:0]  TIMER_BUS_ADDR,
   output [31:0] TIMER_BUS_WDATA,
   input [31:0]  TIMER_BUS_RDATA
   );
   wire              dsel_ram, dsel_io, dsel_sys;
   wire              dsel_sys_plic, dsel_sys_timer;
   wire              dsel_illegal;
   assign dsel_ram       = (D_MEM_ADDR[31:30] == 2'b00);
   assign dsel_io        = (D_MEM_ADDR[31:30] == 2'b10);
   assign dsel_sys       = (D_MEM_ADDR[31:30] == 2'b11);
   assign dsel_sys_plic  = (dsel_sys & (D_MEM_ADDR[29:16] == 14'h0000));
   assign dsel_sys_timer = (dsel_sys & (D_MEM_ADDR[29:16] == 14'h0001));
   assign dsel_illegal   = D_MEM_ENA & ~(dsel_ram | dsel_io | dsel_sys |
                                        dsel_sys_plic | dsel_sys_timer);
   assign C_MEM_ENA   = (D_MEM_ENA & dsel_ram)?D_MEM_ENA:1'b0;
   assign C_MEM_WSTB  = (D_MEM_ENA & dsel_ram)?D_MEM_WSTB:4'd0;
   assign C_MEM_ADDR  = (D_MEM_ENA & dsel_ram)?D_MEM_ADDR:32'd0;
   assign C_MEM_WDATA = (D_MEM_ENA & dsel_ram)?D_MEM_WDATA:32'd0;
   assign PERIPHERAL_BUS_ENA   = (D_MEM_ENA & dsel_io)?D_MEM_ENA:1'b0;
   assign PERIPHERAL_BUS_ADDR  = (D_MEM_ENA & dsel_io)?D_MEM_ADDR:32'd0;
   assign PERIPHERAL_BUS_WSTB  = (D_MEM_ENA & dsel_io)?D_MEM_WSTB:4'd0;
   assign PERIPHERAL_BUS_WDATA = (D_MEM_ENA & dsel_io)?D_MEM_WDATA:32'd0;
   assign PLIC_BUS_WE    = (D_MEM_ENA & dsel_sys_plic)?D_MEM_ENA & |D_MEM_WSTB:1'b0;
   assign PLIC_BUS_ADDR  = (D_MEM_ENA & dsel_sys_plic)?D_MEM_ADDR[5:2]:4'd0;
   assign PLIC_BUS_WDATA = (D_MEM_ENA & dsel_sys_plic)?D_MEM_WDATA:32'd0;
   assign TIMER_BUS_WE    = (D_MEM_ENA & dsel_sys_timer)?D_MEM_ENA & |D_MEM_WSTB:1'b0;
   assign TIMER_BUS_ADDR  = (D_MEM_ENA & C_MEM_ENA & dsel_sys_timer)?D_MEM_ADDR[5:2]:4'd0;
   assign TIMER_BUS_WDATA = (dsel_sys_timer)?D_MEM_WDATA:32'd0;
   assign D_MEM_WAIT = (D_MEM_ENA & dsel_ram)?C_MEM_WAIT:
                      (D_MEM_ENA & dsel_io)?PERIPHERAL_BUS_WAIT:
                      1'b0;
   assign D_MEM_RDATA = (dsel_ram)?C_MEM_RDATA:
                       (dsel_io)?PERIPHERAL_BUS_RDATA:
                       (dsel_sys_plic)?PLIC_BUS_RDATA:
                       (dsel_sys_timer)?TIMER_BUS_RDATA:
                       32'd0;
   assign D_MEM_BADMEM_EXCPT = ((~C_MEM_WAIT & ~PERIPHERAL_BUS_WAIT) & D_MEM_ENA & dsel_ram)?C_MEM_BADMEM_EXCPT:
                              dsel_illegal;
endmodule