module user_logic_9
(
  IRQ,
  VIO_IRQ_TICK,
  vio_rise_edge,
  slv_reg,
  Bus2IP_Clk,                     
  Bus2IP_Resetn,                  
  Bus2IP_Data,                    
  Bus2IP_BE,                      
  Bus2IP_RdCE,                    
  Bus2IP_WrCE,                    
  IP2Bus_Data,                    
  IP2Bus_RdAck,                   
  IP2Bus_WrAck,                   
  IP2Bus_Error                    
); 
parameter C_NUM_REG                      = 1;
parameter C_SLV_DWIDTH                   = 32;
output                                    IRQ;
input                                     VIO_IRQ_TICK;
output                                    vio_rise_edge;
output                                    slv_reg;
input                                     Bus2IP_Clk;
input                                     Bus2IP_Resetn;
input      [C_SLV_DWIDTH-1 : 0]           Bus2IP_Data;
input      [C_SLV_DWIDTH/8-1 : 0]         Bus2IP_BE;
input      [C_NUM_REG-1 : 0]              Bus2IP_RdCE;
input      [C_NUM_REG-1 : 0]              Bus2IP_WrCE;
output     [C_SLV_DWIDTH-1 : 0]           IP2Bus_Data;
output                                    IP2Bus_RdAck;
output                                    IP2Bus_WrAck;
output                                    IP2Bus_Error;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg0;
  wire       [0 : 0]                        slv_reg_write_sel;
  wire       [0 : 0]                        slv_reg_read_sel;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;
  reg        [3 : 0]                        vio_rise_p;
  reg                                       vio_rise_edge_i;
  assign
    slv_reg_write_sel = Bus2IP_WrCE[0:0],
    slv_reg_read_sel  = Bus2IP_RdCE[0:0],
    slv_write_ack     = Bus2IP_WrCE[0],
    slv_read_ack      = Bus2IP_RdCE[0];
  always @( posedge Bus2IP_Clk )
    begin
      if ( Bus2IP_Resetn == 1'b0 )
        begin
          slv_reg0 <= 0;
        end
      else begin
        if ( vio_rise_edge_i == 1'b1) begin
		    slv_reg0[0] <= 1'b1;
        end
        case ( slv_reg_write_sel )
          1'b1 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg0[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
        endcase
      end
    end 
  always @( slv_reg_read_sel or slv_reg0 )
    begin 
      case ( slv_reg_read_sel )
        1'b1 : slv_ip2bus_data <= slv_reg0;
        default : slv_ip2bus_data <= 0;
      endcase
    end 
  always @( posedge Bus2IP_Clk )
    begin
      if ( Bus2IP_Resetn == 1'b0 ) begin
        vio_rise_edge_i <= 1'b0;
		  vio_rise_p <= 4'b0;
      end else begin
		  vio_rise_p <= {vio_rise_p[2:0], VIO_IRQ_TICK};
		  vio_rise_edge_i <= ~vio_rise_p[3] & vio_rise_p[2];
	  end
  end
  assign IRQ           = slv_reg0[0];
  assign vio_rise_edge = vio_rise_edge_i;
  assign slv_reg       = slv_reg0[0];
  assign IP2Bus_Data = (slv_read_ack == 1'b1) ? slv_ip2bus_data :  0 ;
  assign IP2Bus_WrAck = slv_write_ack;
  assign IP2Bus_RdAck = slv_read_ack;
  assign IP2Bus_Error = 0;
endmodule