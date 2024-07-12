module test_core(
                 input wire           clk,
                 input wire           reset_n,
                 input wire           cs,
                 input wire           we,
                 input wire [7 : 0]   address,
                 input wire [31 : 0]  write_data,
                 output wire [31 : 0] read_data,
                 output wire          error,
                 output wire [7 : 0]  debug
                );
  parameter ADDR_CORE_ID_0   = 8'h00;
  parameter ADDR_CORE_ID_1   = 8'h01;
  parameter ADDR_CORE_TYPE_0 = 8'h02;
  parameter ADDR_CORE_TYPE_1 = 8'h03;
  parameter ADDR_RW_REG      = 8'h10;
  parameter ADDR_DEBUG_REG   = 8'h20;
  parameter CORE_ID_0   = 32'h74657374; 
  parameter CORE_ID_1   = 32'h636f7265; 
  parameter CORE_TYPE_0 = 32'h30303030; 
  parameter CORE_TYPE_1 = 32'h30303162; 
  parameter RW_DEFAULT    = 32'h11223344;
  parameter DEBUG_DEFAULT = 8'h55;
  reg [31 : 0] rw_reg;
  reg [31 : 0] rw_new;
  reg          rw_we;
  reg [7 : 0]  debug_reg;
  reg [7 : 0]  debug_new;
  reg          debug_we;
  reg          tmp_error;
  reg [31 : 0] tmp_read_data;
  assign error     = tmp_error;
  assign read_data = tmp_read_data;
  assign debug     = debug_reg;
  always @ (posedge clk)
    begin: reg_update
      if (!reset_n)
        begin
          rw_reg    <= RW_DEFAULT;
          debug_reg <= DEBUG_DEFAULT;
        end
      else
        begin
          if (rw_we)
            begin
              rw_reg <= rw_new;
            end
          if (debug_we)
            begin
              debug_reg <= debug_new;
            end
        end
    end 
  always @*
    begin: read_write_logic
      rw_new        = 32'h00000000;
      rw_we         = 0;
      debug_new     = 8'h00;
      debug_we      = 0;
      tmp_read_data = 32'h00000000;
      tmp_error     = 0;
      if (cs)
        begin
          if (we)
            begin
              case (address)
                ADDR_RW_REG:
                  begin
                    rw_new = write_data;
                    rw_we  = 1;
                  end
                ADDR_DEBUG_REG:
                  begin
                    debug_new = write_data[7 : 0];
                    debug_we  = 1;
                  end
                default:
                  begin
                    tmp_error = 1;
                  end
              endcase 
            end
          else
            begin
              case (address)
                ADDR_CORE_ID_0:
                  begin
                    tmp_read_data = CORE_ID_0;
                  end
                ADDR_CORE_ID_1:
                  begin
                    tmp_read_data = CORE_ID_1;
                  end
                ADDR_CORE_TYPE_0:
                  begin
                    tmp_read_data = CORE_TYPE_0;
                  end
                ADDR_CORE_TYPE_1:
                  begin
                    tmp_read_data = CORE_TYPE_1;
                  end
                ADDR_RW_REG:
                  begin
                    tmp_read_data = rw_reg;
                  end
                ADDR_DEBUG_REG:
                  begin
                    tmp_read_data = {24'h000000, debug_reg};
                  end
                default:
                  begin
                    tmp_error = 1;
                  end
              endcase 
            end
        end
    end 
endmodule