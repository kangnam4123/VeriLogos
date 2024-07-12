module stierlitz
  (clk,
   reset,
   enable,
   bus_ready,
   bus_address,
   bus_data,
   bus_rw,
   bus_start_op,
   cy_hpi_address,
   cy_hpi_data,
   cy_hpi_oen,
   cy_hpi_wen,
   cy_hpi_csn,
   cy_hpi_irq,
   cy_hpi_resetn
   );
   localparam [1:0] 
     HPI_REG_DMA_DATA = 2'b00,    
     HPI_REG_MAILBOX = 2'b01,     
     HPI_REG_DMA_ADDRESS = 2'b10, 
     HPI_REG_STATUS = 2'b11;      
   localparam [2:0]
     STATE_IDLE            =  0,
     STATE_MBX_READ_1      =  1,
     STATE_MBX_READ_2      =  2,
     STATE_MBX_WRITE_1     =  3,
     STATE_MBX_WRITE_2     =  4,
     STATE_CMD             =  5,
     STATE_BUS_READ        =  6,
     STATE_BUS_WRITE       =  7;
   input wire clk;    
   input wire reset;  
   input wire enable; 
   output wire [40:0] bus_address;  
   inout wire  [7:0]  bus_data;     
   output wire 	      bus_rw;       
   output wire 	      bus_start_op; 
   input wire 	      bus_ready;    
   output wire [1:0] cy_hpi_address;  
   inout wire [15:0] cy_hpi_data;     
   output wire 	     cy_hpi_oen;      
   output wire 	     cy_hpi_wen;      
   output wire 	     cy_hpi_csn;      
   input wire 	     cy_hpi_irq;      
   output wire 	     cy_hpi_resetn;   
   reg [7:0] 	     LBA [3:0]; 
   reg [8:0] 	     byte_offset; 
   assign bus_address[8:0]   = byte_offset;
   assign bus_address[16:9]  = LBA[0];
   assign bus_address[24:17] = LBA[1];
   assign bus_address[32:25] = LBA[2];
   assign bus_address[40:33] = LBA[3];
   reg [7:0] 	     bus_byte_out;
   reg 		     bus_rw_control; 
   assign bus_rw = bus_rw_control;
   assign bus_data = bus_rw_control ? 8'bz : bus_byte_out;
   reg 		     bus_op;
   assign bus_start_op = bus_op;
   assign cy_hpi_csn = ~enable;
   assign cy_hpi_resetn = ~reset; 
   assign cy_hpi_address[1:0] = HPI_REG_MAILBOX;       
   reg 		     read_enable;
   reg 		     write_enable;
   assign cy_hpi_oen = ~read_enable;
   assign cy_hpi_wen = ~write_enable; 
   wire 	     output_enable;
   assign output_enable = write_enable & ~(read_enable) & enable;
   reg [15:0] 	     hpi_data_out_reg;
   assign cy_hpi_data = output_enable ? hpi_data_out_reg : 16'bz;
   reg [15:0] 	     hpi_data_in_reg;
   reg [2:0] 	     hpi_state;          
   always @(posedge clk, posedge reset)
     if (reset)
       begin
	  read_enable <= 0;
	  write_enable <= 0;
	  bus_rw_control <= 1;
	  hpi_data_in_reg <= 0;
	  hpi_data_out_reg <= 0;
	  LBA[0] <= 0;
	  LBA[1] <= 0;
	  LBA[2] <= 0;
	  LBA[3] <= 0;
	  bus_op <= 0;
	  bus_byte_out <= 0;
	  byte_offset <= 0;
	  hpi_state = STATE_IDLE;
       end
     else
       begin
	  case (hpi_state)
	    STATE_IDLE:
	      begin
		 read_enable <= 0;
		 write_enable <= 0;
		 bus_rw_control <= 1;
		 hpi_state = cy_hpi_irq ? STATE_MBX_READ_1 : STATE_IDLE;
	      end
	    STATE_MBX_READ_1:
	      begin
		 read_enable <= 1;
		 write_enable <= 0;
		 hpi_state = STATE_MBX_READ_2;
	      end
	    STATE_MBX_READ_2:
	      begin
		 read_enable <= 1;
		 write_enable <= 0;
		 hpi_data_in_reg <= cy_hpi_data;
		 hpi_state = STATE_CMD;
	      end
	    STATE_MBX_WRITE_1:
	      begin
		 read_enable <= 0;
		 write_enable <= 1;
		 bus_op <= 0;
		 hpi_state = STATE_MBX_WRITE_2;
	      end
	    STATE_MBX_WRITE_2:
	      begin
		 read_enable <= 0;
		 write_enable <= 0;
		 byte_offset <= bus_ready ? (byte_offset + 1) : byte_offset;
		 hpi_state = STATE_IDLE;
	      end
	    STATE_CMD:
	      begin
		 read_enable <= 0;
		 write_enable <= 0;
		 case (hpi_data_in_reg[15:14])
		   2'b00:
		     begin
			LBA[(hpi_data_in_reg[9:8])] <= hpi_data_in_reg[7:0];
			byte_offset <= 0; 
			hpi_state = STATE_IDLE;
		     end
		   2'b10:
		     begin
			bus_byte_out <= hpi_data_in_reg[7:0];
			bus_rw_control <= 0; 
			hpi_state = STATE_BUS_WRITE;
		     end
		   2'b01:
		     begin
			bus_rw_control <= 1; 
			bus_op <= 1;
			hpi_state = STATE_BUS_READ;
		     end
		   default:
		     begin
			hpi_state = STATE_IDLE;
		     end
		 endcase 
	      end
	    STATE_BUS_READ:
	      begin
		 read_enable <= 0;
		 write_enable <= 0;
		 hpi_data_out_reg[7:0] <= bus_data; 
		 hpi_state = bus_ready ? STATE_MBX_WRITE_1 : STATE_BUS_READ;
	      end
	    STATE_BUS_WRITE:
	      begin
		 read_enable <= 0;
		 write_enable <= 0;
		 bus_op <= 1;
		 hpi_state = bus_ready ? STATE_MBX_WRITE_1 : STATE_BUS_WRITE;
	      end
	    default:
	      begin
		 read_enable <= 0;
		 write_enable <= 0;
		 hpi_state = STATE_IDLE;
	      end
	  endcase 
       end 
endmodule