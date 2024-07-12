module aximaster_stub (
   m_axi_awid, m_axi_awaddr, m_axi_awlen, m_axi_awsize, m_axi_awburst,
   m_axi_awlock, m_axi_awcache, m_axi_awprot, m_axi_awqos,
   m_axi_awvalid, m_axi_wid, m_axi_wdata, m_axi_wstrb, m_axi_wlast,
   m_axi_wvalid, m_axi_bready, m_axi_arid, m_axi_araddr, m_axi_arlen,
   m_axi_arsize, m_axi_arburst, m_axi_arlock, m_axi_arcache,
   m_axi_arprot, m_axi_arqos, m_axi_arvalid, m_axi_rready,
   m_axi_aclk, m_axi_aresetn, m_axi_awready, m_axi_wready, m_axi_bid,
   m_axi_bresp, m_axi_bvalid, m_axi_arready, m_axi_rid, m_axi_rdata,
		  m_axi_rresp, m_axi_rlast, m_axi_rvalid
   );
   parameter M_IDW  = 12;
   input  	       m_axi_aclk;    
   input  	       m_axi_aresetn; 
   output [M_IDW-1:0]  m_axi_awid;    
   output [31 : 0]     m_axi_awaddr;  
   output [7 : 0]      m_axi_awlen;   
   output [2 : 0]      m_axi_awsize;  
   output [1 : 0]      m_axi_awburst; 
   output              m_axi_awlock;  
   output [3 : 0]      m_axi_awcache; 
   output [2 : 0]      m_axi_awprot;  
   output [3 : 0]      m_axi_awqos;   
   output 	       m_axi_awvalid; 
   input 	       m_axi_awready; 
   output [M_IDW-1:0]  m_axi_wid;     
   output [63 : 0]     m_axi_wdata;   
   output [7 : 0]      m_axi_wstrb;   
   output 	       m_axi_wlast;   
   output 	       m_axi_wvalid;  
   input 	       m_axi_wready;  
   input [M_IDW-1:0]     m_axi_bid;
   input [1 : 0]       m_axi_bresp;   
   input 	       m_axi_bvalid;  
   output 	       m_axi_bready;  
   output [M_IDW-1:0]  m_axi_arid;    
   output [31 : 0]     m_axi_araddr;  
   output [7 : 0]      m_axi_arlen;   
   output [2 : 0]      m_axi_arsize;  
   output [1 : 0]      m_axi_arburst; 
   output              m_axi_arlock;  
   output [3 : 0]      m_axi_arcache; 
   output [2 : 0]      m_axi_arprot;  
   output [3 : 0]      m_axi_arqos;   
   output 	       m_axi_arvalid; 
   input 	       m_axi_arready; 
   input [M_IDW-1:0]   m_axi_rid; 
   input [63 : 0]      m_axi_rdata;   
   input [1 : 0]       m_axi_rresp;   
   input 	       m_axi_rlast;   
   input 	       m_axi_rvalid;  
   output 	       m_axi_rready;  
   assign   m_axi_awid    ='b0;
   assign   m_axi_awaddr  ='b0;
   assign   m_axi_awlen   ='b0;
   assign   m_axi_awsize  ='b0;
   assign   m_axi_awburst ='b0;
   assign   m_axi_awlock  ='b0;
   assign   m_axi_awcache ='b0;
   assign   m_axi_awprot  ='b0;
   assign   m_axi_awqos   ='b0;
   assign   m_axi_awvalid ='b0;
   assign   m_axi_wid     ='b0;
   assign   m_axi_wdata   ='b0;
   assign   m_axi_wstrb   ='b0;
   assign   m_axi_wlast   ='b0;
   assign   m_axi_wvalid  ='b0;
   assign   m_axi_bready  ='b0;
   assign   m_axi_arid    ='b0;
   assign   m_axi_araddr  ='b0;
   assign   m_axi_arlen   ='b0;
   assign   m_axi_arsize  ='b0;
   assign   m_axi_arburst ='b0;
   assign   m_axi_arlock  ='b0;
   assign   m_axi_arcache ='b0;
   assign   m_axi_arprot  ='b0;
   assign   m_axi_arqos   ='b0;
   assign   m_axi_arvalid ='b0;
   assign   m_axi_rready  ='b0;
endmodule