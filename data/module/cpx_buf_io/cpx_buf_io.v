module cpx_buf_io(
   cpx_io_grant_bufio_ca, io_cpx_req_bufio_cq_l, 
   cpx_io_grant_ca, io_cpx_req_cq
   );
   output [7:0]         cpx_io_grant_bufio_ca;
   output [7:0]		io_cpx_req_bufio_cq_l;	
   input [7:0]          cpx_io_grant_ca;
   input [7:0]		io_cpx_req_cq;	
   assign               cpx_io_grant_bufio_ca    =  cpx_io_grant_ca;
   assign		io_cpx_req_bufio_cq_l    =  ~io_cpx_req_cq;
endmodule