module mc_de
  #(parameter BYTES = 4)
  (
   input                mclock,
   input                reset_n,
   input                line_actv_4,
   input                de_read,
   input                de_rmw,
   input                de_pc_empty,
   input [3:0]          de_page,
   input [31:0]         de_address,
   input                de_push,
   input                de_almost_full,
   input                de_zen,
   output reg           fifo_push,
   output               de_popen,
   output reg           de_last,
   output reg           de_last4,
   output reg           de_pc_pop,
   output reg [1:0]     de_arb_cmd,  
   output reg [31:0]    de_arb_address,
   output reg           mcb,       
   output reg           de_push_mff,
   output reg           de_push_mff_z,
   output reg           de_push_mff_a
   );
  localparam            
                        IDLE      = 2'b00,
                        WAIT_GRAB = 2'b01,
                        DATA_GRAB = 2'b10,
                        WAIT4GNT  = 2'b11;
  reg [1:0]     de_cs, de_ns;         
  reg [6:0]     page_count;           
  reg           grab_data;
  reg [4:0]     de_popen_pipe;
  reg           fifo_push_d;          
  always @ (posedge mclock or negedge reset_n)
    if(!reset_n) begin
      mcb             <= 1'b0;
      de_cs           <= IDLE;
      de_popen_pipe   <= 5'b0;
      de_push_mff     <= 1'b0;
      de_push_mff_z   <= 1'b0;
      de_push_mff_a   <= 1'b0;
      de_last         <= 1'b0;
      de_last4        <= 1'b0;
      page_count      <= 7'b0;
      de_arb_address  <= 32'b0;
      fifo_push_d     <= 1'b0;
    end else begin
      fifo_push_d <= fifo_push;
      de_cs <= de_ns;
      mcb <= |de_cs;
      if (grab_data) begin
        de_arb_address <= de_address;
        casex ({de_read, de_rmw})
          2'b01: de_arb_cmd <= 2'd2;
          2'b00: de_arb_cmd <= 2'd0;
          2'b1x: de_arb_cmd <= 2'd1;
        endcase 
      end 
      de_last  <= 1'b0;
      de_last4 <= 1'b0;
      de_popen_pipe <= (de_popen_pipe << 1) | (~de_read & |page_count);
      de_push_mff   <=  de_popen_pipe[4];
      de_push_mff_z <= (de_popen_pipe[4] & de_zen);
      de_push_mff_a <=  de_popen_pipe[1];
      if (grab_data)
        if (line_actv_4)
          page_count <= de_page + 5'b1;
        else if (BYTES == 16)
          page_count <= de_page + 5'b1;
        else if (BYTES == 8)
          page_count <= {de_page, 1'b1} + 5'b1;
        else 
          page_count <= {de_page, 2'b11} + 5'b1;
      else if ((de_push || ~de_read) && |page_count) begin
        page_count <= page_count - 7'b1;
        de_last    <= (page_count == 1);
      end
      if (BYTES == 4)
        de_last4 <= (page_count <= 4);
      else if (BYTES == 8)
        de_last4 <= (page_count <= 2);
      else
        de_last4 <= (page_count == 1);
    end
      assign de_popen = de_popen_pipe[0];
  always @* begin
    de_pc_pop    = 1'b0;
    grab_data    = 1'b0;
    fifo_push    = 1'b0;
    de_ns        = de_cs; 
    case (de_cs)
      IDLE: begin
        if (~de_pc_empty && ~de_almost_full && ~|page_count 
          && ~fifo_push_d && ~|de_popen_pipe[2:0]) begin
          de_pc_pop = 1'b1; 
          de_ns     = WAIT_GRAB;
        end else
          de_ns     = IDLE;
      end
      WAIT_GRAB: de_ns = DATA_GRAB;
      DATA_GRAB: begin
        grab_data = 1'b1;
        de_ns     = WAIT4GNT;
      end
      WAIT4GNT: begin
        fifo_push = 1'b1;
        de_ns = IDLE;
      end
    endcase
  end
endmodule