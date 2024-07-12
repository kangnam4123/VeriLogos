module crc_control_unit
(
 output reg [1:0] byte_sel,
 output bypass_byte0,
 output buffer_full,
 output read_wait,
 output bypass_size,
 output set_crc_init_sel,
 output clear_crc_init_sel,
 output crc_out_en,
 output byte_en,
 output reset_pending,
 input [1:0] size_in,
 input write,
 input reset_chain,
 input clk,
 input rst_n
);
localparam EMPTY   = 2'b00;
localparam WRITE_1 = 2'b01;
localparam WRITE_2 = 2'b10;
localparam BYPASS  = 2'b11;
localparam IDLE   = 3'b100;
localparam BYTE_0 = 3'b000;
localparam BYTE_1 = 3'b001;
localparam BYTE_2 = 3'b010;
localparam BYTE_3 = 3'b011;
localparam NO_RESET = 3'b000;
localparam RESET    = 3'b001;
localparam WAIT     = 3'b010;
localparam WRITE    = 3'b011;
localparam RESET_2  = 3'b100;
localparam BYTE      = 2'b00;
localparam HALF_WORD = 2'b01;
localparam WORD      = 2'b10;
reg [1:0] state_full;
reg [2:0] state_byte;
reg [2:0] state_reset;
reg [1:0] next_state_full;
reg [2:0] next_state_byte;
reg [2:0] next_state_reset;
wire last_byte;
wire has_data;
always @(posedge clk)
 begin
  if(!rst_n)
   state_full <= EMPTY;
  else
   state_full <= next_state_full;
 end
assign last_byte = (size_in == BYTE      && state_byte == BYTE_0) ||
                   (size_in == HALF_WORD && state_byte == BYTE_1) ||
                   (size_in == WORD      && state_byte == BYTE_3) ;
always @(*)
 begin
  next_state_full = state_full;
  case(state_full)
   EMPTY  : next_state_full = (write) ? WRITE_1 : EMPTY;
   WRITE_1: 
    begin
     if(last_byte)
      begin
       if(!write)
        next_state_full = EMPTY;
      end
     else
      begin
       if(write)
        next_state_full = WRITE_2;
      end
    end
   WRITE_2:
    begin
     if(last_byte)
      next_state_full = (write) ? BYPASS : WRITE_1;
    end
   BYPASS :
    begin
     if(last_byte && !write)
      next_state_full = WRITE_1;
    end
  endcase
 end
assign buffer_full = (state_full == WRITE_2 && !last_byte) ||
                     (state_full == BYPASS  && !last_byte);
assign read_wait = (state_byte != IDLE);
assign bypass_byte0 = (state_full != BYPASS); 
assign has_data = (state_full == WRITE_2) ||
                  (state_full == BYPASS ) ;
always @(posedge clk)
 begin
  if(!rst_n)
   state_byte <= IDLE;
  else
   state_byte <= next_state_byte;
 end
always @(*)
 begin
  next_state_byte = state_byte;
  case(state_byte)
   IDLE: next_state_byte = (write) ? BYTE_0 : IDLE;
   BYTE_0:
    begin
     if(size_in == BYTE)
      begin
       if(!write && !has_data)
        next_state_byte = IDLE;
      end
     else
      begin
       next_state_byte = BYTE_1;
      end
    end
   BYTE_1:
    begin
     if(size_in == HALF_WORD)
      begin
       if(has_data || (write && !buffer_full))
        next_state_byte = BYTE_0;
       else
        next_state_byte = IDLE;
      end
     else
      begin
       next_state_byte = BYTE_2;
      end
    end
   BYTE_2:
    begin
     next_state_byte = BYTE_3;
    end
   BYTE_3:
    begin
     if(has_data || (write && !buffer_full))
      next_state_byte = BYTE_0;
     else
      next_state_byte = IDLE;
    end
  endcase
 end
always @(*)
 begin
  byte_sel = 2'b00;
  case(state_byte)
   BYTE_0: byte_sel = BYTE_0;
   BYTE_1: byte_sel = BYTE_1;
   BYTE_2: byte_sel = BYTE_2;
   BYTE_3: byte_sel = BYTE_3;
  endcase
 end
assign bypass_size = !( (state_full != BYPASS && state_byte != BYTE_0) ||
                        (state_full == BYPASS)
                      );
assign crc_out_en = (state_byte != IDLE);
assign byte_en = (state_byte == BYTE_0 && (size_in == HALF_WORD || size_in == WORD) && state_full != BYPASS) ||
                 (last_byte && has_data);
always @(posedge clk)
 begin
  if(!rst_n)
   state_reset <= NO_RESET;
  else
   state_reset <= next_state_reset;
 end
always @(*)
 begin
  next_state_reset = state_reset;
  case(state_reset)
   NO_RESET:
    begin
     if((reset_chain && !has_data && state_byte != IDLE && !last_byte) || (reset_chain && has_data && last_byte))
      next_state_reset = RESET;
     if(reset_chain  && has_data && !last_byte)
      next_state_reset = WAIT;
    end
   RESET:
    begin
     if(last_byte)
      next_state_reset = NO_RESET;
     else
      next_state_reset = (write) ? WRITE : RESET;
    end
   WAIT:
    begin
     if(last_byte)
      next_state_reset = (write) ? WRITE : RESET;
     else
      next_state_reset = WAIT;
    end
   WRITE:
    begin
     if(reset_chain)
      next_state_reset = (last_byte) ? RESET : RESET_2;
     else
      next_state_reset = (last_byte) ? NO_RESET : WRITE;
    end
   RESET_2:
    begin
     if(last_byte)
      next_state_reset = (write) ? WRITE : RESET;
     else
      next_state_reset = RESET_2;
    end
  endcase
 end
assign set_crc_init_sel = (state_byte == BYTE_0);
assign clear_crc_init_sel = (state_reset == NO_RESET && last_byte && reset_chain) ||
                            (state_byte  == IDLE     && reset_chain             ) ||
                            (state_reset == RESET    && last_byte               ) ||
                            (state_reset == WRITE    && last_byte               ) ||
                            (state_reset == RESET_2  && last_byte               ) ;
assign reset_pending = (state_reset != NO_RESET);
endmodule