module mult(
            input wire                        clk,
            input wire                        reset_n,
            input wire                        cs,
            input wire                        we,
            input wire  [7 : 0]               addr,
            input wire  [(API_WIDTH - 1) : 0] write_data,
            output wire [(API_WIDTH - 1) : 0] read_data
           );
  parameter API_WIDTH       = 16;
  parameter OPA_WIDTH       = 256;
  parameter OPB_WIDTH       = 64;
  localparam OPA_WORDS      = OPA_WIDTH / API_WIDTH;
  localparam OPA_BASE_ADDR  = 8'h00;
  localparam OPA_TOP_ADDR   = (OPA_BASE_ADDR + OPA_WORDS - 1);
  localparam OPB_WORDS      = OPB_WIDTH / API_WIDTH;
  localparam OPB_BASE_ADDR  = 8'h40;
  localparam OPB_TOP_ADDR   = (OPB_BASE_ADDR + OPB_WORDS - 1);
  localparam PROD_WIDTH     = OPA_WIDTH + OPB_WIDTH;
  localparam PROD_WORDS     = PROD_WIDTH / API_WIDTH;
  localparam PROD_BASE_ADDR = 8'h80;
  localparam PROD_TOP_ADDR  = (PROD_BASE_ADDR + PROD_WORDS - 1);
  reg [(OPA_WIDTH - 1) : 0] opa_reg;
  reg [(OPA_WIDTH - 1) : 0] opa_new;
  reg                       opa_we;
  reg [(OPA_WIDTH - 1) : 0] opb_reg;
  reg [(OPA_WIDTH - 1) : 0] opb_new;
  reg                       opb_we;
  reg [(PROD_WIDTH - 1) : 0] prod_reg;
  reg [(PROD_WIDTH - 1) : 0] prod_new;
  reg [(API_WIDTH -1) : 0] tmp_read_data;
  assign read_data = tmp_read_data;
  always @ (posedge clk or negedge reset_n)
    begin : reg_update
      if (!reset_n)
        begin
          opa_reg  <= {(OPA_WIDTH){1'h0}};
          opb_reg  <= {(OPB_WIDTH){1'h0}};
          prod_reg <= {(PROD_WIDTH){1'h0}};
        end
      else
        begin
          prod_reg <= prod_new;
          if (opa_we)
            opa_reg <= opa_new;
          if (opb_we)
            opb_reg <= opb_new;
        end
    end 
  always @*
    begin : mult_logic
      prod_new = opa_reg * opb_reg;
    end
  always @*
    begin : api
      tmp_read_data = {(API_WIDTH){1'h0}};
      opa_new       = opa_reg;
      opa_we        = 0;
      opb_new       = opb_reg;
      opb_we        = 0;
      if (cs)
        begin
          if (we)
            begin
              if ((addr >= OPA_BASE_ADDR) && (addr <= OPA_TOP_ADDR))
                begin
                  opa_new[API_WIDTH * (addr - OPA_BASE_ADDR) +: API_WIDTH] = write_data;
                  opa_we = 1;
                end
              if ((addr >= OPB_BASE_ADDR) && (addr <= OPB_TOP_ADDR))
                begin
                  opb_new[API_WIDTH * (addr - OPB_BASE_ADDR) +: API_WIDTH] = write_data;
                  opb_we = 1;
                end
            end
          else
            begin
              if ((addr >= PROD_BASE_ADDR) && (addr <= PROD_TOP_ADDR))
                tmp_read_data = prod_reg[API_WIDTH * (addr - PROD_BASE_ADDR) +: API_WIDTH];
            end
        end
    end 
endmodule