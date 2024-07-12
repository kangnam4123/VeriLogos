module fifo_generator_v13_1_1_axic_reg_slice #
  (
   parameter C_FAMILY     = "virtex7",
   parameter C_DATA_WIDTH = 32,
   parameter C_REG_CONFIG = 32'h00000000
   )
  (
   input  wire                      ACLK,
   input  wire                      ARESET,
   input  wire [C_DATA_WIDTH-1:0]   S_PAYLOAD_DATA,
   input  wire                      S_VALID,
   output wire                      S_READY,
   output wire [C_DATA_WIDTH-1:0]   M_PAYLOAD_DATA,
   output wire                      M_VALID,
   input  wire                      M_READY
   );
  generate
    if (C_REG_CONFIG == 32'h00000000)
    begin
      reg [1:0] state;
      localparam [1:0] 
        ZERO = 2'b10,
        ONE  = 2'b11,
        TWO  = 2'b01;
      reg [C_DATA_WIDTH-1:0] storage_data1 = 0;
      reg [C_DATA_WIDTH-1:0] storage_data2 = 0;
      reg                    load_s1;
      wire                   load_s2;
      wire                   load_s1_from_s2;
      reg                    s_ready_i; 
      wire                   m_valid_i; 
      assign S_READY = s_ready_i;
      assign M_VALID = m_valid_i;
      reg  areset_d1; 
      always @(posedge ACLK) begin
        areset_d1 <= ARESET;
      end
      always @(posedge ACLK) 
      begin
        if (load_s1)
          if (load_s1_from_s2)
            storage_data1 <= storage_data2;
          else
            storage_data1 <= S_PAYLOAD_DATA;        
      end
      always @(posedge ACLK) 
      begin
        if (load_s2)
          storage_data2 <= S_PAYLOAD_DATA;
      end
      assign M_PAYLOAD_DATA = storage_data1;
      assign load_s2 = S_VALID & s_ready_i;
      always @ *
      begin
        if ( ((state == ZERO) && (S_VALID == 1)) || 
             ((state == ONE) && (S_VALID == 1) && (M_READY == 1)) ||
             ((state == TWO) && (M_READY == 1)))
          load_s1 = 1'b1;
        else
          load_s1 = 1'b0;
      end 
      assign load_s1_from_s2 = (state == TWO);
      always @(posedge ACLK) begin
        if (ARESET) begin
          s_ready_i <= 1'b0;
          state <= ZERO;
        end else if (areset_d1) begin
          s_ready_i <= 1'b1;
        end else begin
          case (state)
            ZERO: if (S_VALID) state <= ONE; 
            ONE: begin
              if (M_READY & ~S_VALID) state <= ZERO; 
              if (~M_READY & S_VALID) begin
                state <= TWO;  
                s_ready_i <= 1'b0;
              end
            end
            TWO: if (M_READY) begin
              state <= ONE; 
              s_ready_i <= 1'b1;
            end
          endcase 
        end
      end 
      assign m_valid_i = state[0];
    end 
    else if (C_REG_CONFIG == 32'h00000001)
    begin
      reg [C_DATA_WIDTH-1:0] storage_data1 = 0;
      reg                    s_ready_i; 
      reg                    m_valid_i; 
      assign S_READY = s_ready_i;
      assign M_VALID = m_valid_i;
      reg  areset_d1; 
      always @(posedge ACLK) begin
        areset_d1 <= ARESET;
      end
      always @(posedge ACLK) 
      begin
        if (ARESET) begin
          s_ready_i <= 1'b0;
          m_valid_i <= 1'b0;
        end else if (areset_d1) begin
          s_ready_i <= 1'b1;
        end else if (m_valid_i & M_READY) begin
          s_ready_i <= 1'b1;
          m_valid_i <= 1'b0;
        end else if (S_VALID & s_ready_i) begin
          s_ready_i <= 1'b0;
          m_valid_i <= 1'b1;
        end
        if (~m_valid_i) begin
          storage_data1 <= S_PAYLOAD_DATA;        
        end
      end
      assign M_PAYLOAD_DATA = storage_data1;
    end 
    else begin : default_case
      assign M_PAYLOAD_DATA = S_PAYLOAD_DATA;
      assign M_VALID        = S_VALID;
      assign S_READY        = M_READY;      
    end
  endgenerate
endmodule