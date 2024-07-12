module link_rxi_router (
   fifo_read_cvre, read_out, write_out, dst_addr_out, src_addr_out,
   data_out, datamode_out, ctrlmode_out,
   fifo_data_out_cvre, fifo_empty_cvre, wait_in
   );
   parameter AW  = 32;
   parameter MDW = 32;
   parameter FW  = 112;
   parameter XW  = 6;
   parameter YW  = 6;
   parameter ZW  = 6;
   parameter IAW = 20;
   input [FW-1:0]   fifo_data_out_cvre;
   input            fifo_empty_cvre;
   output           fifo_read_cvre;     
   input             wait_in;
   output            read_out;
   output            write_out;
   output [AW-1:0]   dst_addr_out;
   output [AW-1:0]   src_addr_out;
   output [MDW-1:0]  data_out;    
   output [1:0]      datamode_out;
   output [3:0]      ctrlmode_out;
   wire           mesh_write_cvre;
   wire           mesh_read_cvre;
   wire [1:0]     mesh_datamode_cvre;
   wire [3:0]     mesh_ctrlmode_cvre;
   wire [7:0]     mesh_reserved_cvre;
   wire [MDW-1:0] mesh_data_cvre;
   wire [AW-1:0]  mesh_src_addr_cvre;
   wire [AW-1:0]  mesh_dst_addr_cvre;
   wire [1:0]     compare_addr;
   wire           request_cvre;
   assign mesh_write_cvre           = fifo_data_out_cvre[0];
   assign mesh_read_cvre            = fifo_data_out_cvre[1];
   assign mesh_datamode_cvre[1:0]   = fifo_data_out_cvre[3:2];
   assign mesh_ctrlmode_cvre[3:0]   = fifo_data_out_cvre[7:4];
   assign mesh_reserved_cvre[7:0]   = fifo_data_out_cvre[15:8];
   assign mesh_data_cvre[MDW-1:0]   = fifo_data_out_cvre[47:16];
   assign mesh_dst_addr_cvre[AW-1:0]= fifo_data_out_cvre[79:48];
   assign mesh_src_addr_cvre[AW-1:0]= fifo_data_out_cvre[111:80];
   assign request_cvre         = ~fifo_empty_cvre;
   assign fifo_read_cvre       = (request_cvre  & ~wait_in);
   assign read_out             = request_cvre & mesh_read_cvre;
   assign write_out            = request_cvre & mesh_write_cvre;
   assign dst_addr_out[AW-1:0] = mesh_dst_addr_cvre[AW-1:0];
   assign src_addr_out[AW-1:0] = mesh_src_addr_cvre[AW-1:0];
   assign data_out[MDW-1:0]    = mesh_data_cvre[MDW-1:0];   
   assign datamode_out[1:0]    = mesh_datamode_cvre[1:0];
   assign ctrlmode_out[3:0]    = mesh_ctrlmode_cvre[3:0];
endmodule