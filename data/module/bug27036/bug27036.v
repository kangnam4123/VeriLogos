module bug27036;
   reg [2:0]  a_fifo_cam_indices[3:0], lt_fifo_cam_indices[5:0];
   wire [2:0] db0_a_fifo_cam_indices = a_fifo_cam_indices[0];
endmodule