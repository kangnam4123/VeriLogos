module ctrl_top (
  input  wire       clk,
  input  wire       rst_n,
  input  wire [1:0] ir,
  input  wire       cond,
  output reg        ld_ra,
  output reg        ld_ir,
  output reg        ld_pc,
  output reg        ld_rat,
  output reg        ld_rz,
  output reg        ld_rn,
  output reg        pc_at,
  output reg  [1:0] crf,
  output reg        erd,
  output reg        rw,
  output reg        operate
);
  localparam S_FETCH  = 3'b000;
  localparam S_DECO   = 3'b001;
  localparam S_LOAD   = 3'b010;
  localparam S_STORE  = 3'b011;
  localparam S_ARIT   = 3'b100;
  localparam S_BRANCH = 3'b101;
  reg [2:0] state;
  reg [2:0] n_state;
  always @(posedge clk, negedge rst_n)
  begin
    if (rst_n == 1'b0)
      state <= S_FETCH;
    else
      state <= n_state;
  end
  always @(*)
  begin
    n_state = state;
    ld_ra   = 1'b0;
    ld_ir   = 1'b0;
    ld_pc   = 1'b0;
    ld_rat  = 1'b0;
    ld_rz   = 1'b0;
    ld_rn   = 1'b0;
    pc_at   = 1'b0;
    crf     = 2'b00;
    erd     = 1'b0;
    rw      = 1'b0;
    operate = 1'b0;
    case (state)
      S_FETCH:
      begin
        n_state = S_DECO;
        ld_ir   = 1'b1;
        ld_pc   = 1'b1;
      end
      S_DECO:
      begin
        case (ir)
          2'b00:
            n_state = S_LOAD;
          2'b01:
            n_state = S_STORE;
          2'b10:
            if (cond == 1'b0)
              n_state = S_FETCH;
            else
              n_state = S_BRANCH;
          2'b11:
            n_state = S_ARIT;
        endcase
        ld_ra   = 1'b1;
        ld_rat  = 1'b1;
        crf     = 1'b1;
      end
      S_LOAD:
      begin
        n_state = S_FETCH;
        ld_rz   = 1'b1;
        ld_rn   = 1'b1;
        pc_at   = 1'b1;
        erd     = 1'b1;
      end
      S_STORE:
      begin
        n_state = S_FETCH;
        pc_at   = 1'b1;
        rw      = 1'b1;
      end
      S_ARIT:
      begin
        n_state = S_DECO;
        ld_ir   = 1'b1;
        ld_pc   = 1'b1;
        ld_rz   = 1'b1;
        ld_rn   = 1'b1;
        crf     = 2'b10;
        erd     = 1'b1;
        operate = 1'b1;
      end
      S_BRANCH:
      begin
        n_state = S_DECO;
        ld_ir   = 1'b1;
        ld_pc   = 1'b1;
        pc_at   = 1'b1;
      end
    endcase
  end
endmodule