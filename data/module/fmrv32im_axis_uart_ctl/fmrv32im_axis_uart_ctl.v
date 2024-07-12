module fmrv32im_axis_uart_ctl
  (
   input 		 RST_N,
   input 		 CLK,
   input 		     LOCAL_CS,
   input 		     LOCAL_RNW,
   output 		   LOCAL_ACK,
   input [15:0]  LOCAL_ADDR,
   input [3:0] 	 LOCAL_BE,
   input [31:0]  LOCAL_WDATA,
   output [31:0] LOCAL_RDATA,
   output        TX_WRITE,
   output [7:0]  TX_WDATA,
   input         TX_FULL,
   input         TX_AFULL,
   input         TX_EMPTY,
   output        RX_READ,
   input [7:0]   RX_RDATA,
   input         RX_EMPTY,
   input         RX_AEMPTY,
	 output        INTERRUPT,
   input [31:0]  GPIO_I,
   output [31:0] GPIO_O,
   output [31:0] GPIO_OT
   );
   localparam A_STATUS = 16'h00;
   localparam A_INTENA = 16'h04;
   localparam A_TXD    = 16'h08;
   localparam A_RXD    = 16'h0C;
   localparam A_RATE   = 16'h10;
   localparam A_GPIO_O  = 16'h100;
   localparam A_GPIO_I  = 16'h104;
   localparam A_GPIO_OT = 16'h108;
   wire wr_ena, rd_ena, wr_ack;
   reg rd_ack;
   reg [31:0] reg_rdata;
   reg wr_ack_d;
   assign wr_ena = (LOCAL_CS & ~LOCAL_RNW)?1'b1:1'b0;
   assign rd_ena = (LOCAL_CS &  LOCAL_RNW)?1'b1:1'b0;
   assign wr_ack = wr_ena;
   reg reg_int_ena_tx, reg_int_ena_rx;
   reg [31:0] reg_gpio_o, reg_gpio_ot;
   always @(posedge CLK or negedge RST_N) begin
	  if(!RST_N) begin
	  wr_ack_d <= 1'b0;
			reg_int_ena_rx <= 1'b0;
			reg_int_ena_tx <= 1'b0;
      reg_gpio_o <= 32'd0;
      reg_gpio_ot <= 32'd0;
	  end else begin
	    wr_ack_d <= wr_ena;
		 if(wr_ena) begin
			case(LOCAL_ADDR[15:0] & 16'hFFFC)
			  A_INTENA:
				begin
				   reg_int_ena_tx <= LOCAL_WDATA[1];
				   reg_int_ena_rx <= LOCAL_WDATA[0];
				end
        A_GPIO_O:
        begin
          reg_gpio_o <= LOCAL_WDATA;
        end
        A_GPIO_OT:
        begin
          reg_gpio_ot <= LOCAL_WDATA;
        end
			  default:
				begin
				end
			endcase
		 end
	  end
   end
   reg rd_ack_d;
   always @(posedge CLK or negedge RST_N) begin
	  if(!RST_N) begin
		 rd_ack <= 1'b0;
		 rd_ack_d <= 1'b0;
		 reg_rdata[31:0] <= 32'd0;
	  end else begin
			rd_ack <= rd_ena;
			case(LOCAL_ADDR[15:0] & 16'hFFFC)
			  A_STATUS: reg_rdata[31:0] <= {16'd0, 5'd0, TX_EMPTY, TX_AFULL, TX_FULL, 6'd0, RX_AEMPTY, RX_EMPTY};
			  A_INTENA: reg_rdata[31:0] <= {30'd0, reg_int_ena_tx, reg_int_ena_rx};
			  A_TXD:    reg_rdata[31:0] <= 32'd0;
			  A_RXD:    reg_rdata[31:0] <= {24'd0, RX_RDATA};
        A_GPIO_O:  reg_rdata[31:0] <= reg_gpio_o;
        A_GPIO_I:  reg_rdata[31:0] <= GPIO_I;
        A_GPIO_OT: reg_rdata[31:0] <= reg_gpio_ot;
			  default:  reg_rdata[31:0]  <= 32'd0;
			endcase
	  end
   end
   assign LOCAL_ACK         = (wr_ack | rd_ack);
   assign LOCAL_RDATA[31:0] = reg_rdata[31:0];
	 assign TX_WRITE = wr_ena & ~wr_ack_d & ((LOCAL_ADDR[7:0] & 8'hFC) == A_TXD);
	 assign TX_WDATA = LOCAL_WDATA[7:0];
	 assign RX_READ  = rd_ena & ~rd_ack & ((LOCAL_ADDR[7:0] & 8'hFC) == A_RXD);
	 assign INTERRUPT = (reg_int_ena_tx & TX_FULL) | (reg_int_ena_rx & RX_EMPTY);
   assign GPIO_O  = reg_gpio_o;
   assign GPIO_OT = reg_gpio_ot;
endmodule