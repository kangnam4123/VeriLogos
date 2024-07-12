module cic_decim
  #(
    parameter DATAIN_WIDTH = 16,
    parameter DATAOUT_WIDTH = DATAIN_WIDTH,
    parameter M = 2,
    parameter N = 5,
    parameter MAXRATE = 64,
    parameter BITGROWTH = 35, 
    parameter ROUND_CONVERGENT = 0
  )
  (
    input                      clk_i,
    input                      rst_i,
    input                      en_i,
    input [DATAIN_WIDTH-1:0]   data_i,
    output [DATAOUT_WIDTH-1:0] data_o,
    input                      act_i,
    input                      act_out_i,
    output                     val_o
  );
  localparam DATAOUT_FULL_WIDTH = DATAIN_WIDTH + BITGROWTH;
  localparam DATAOUT_EXTRA_BITS = DATAOUT_FULL_WIDTH - DATAOUT_WIDTH;
  wire [DATAOUT_FULL_WIDTH-1:0] datain_extended;
  reg [DATAOUT_FULL_WIDTH-1:0]  integrator [0:N-1];
  reg [DATAOUT_FULL_WIDTH-1:0]  diffdelay [0:N-1][0:M-1];
  reg [DATAOUT_FULL_WIDTH-1:0]  pipe [0:N-1];
  wire[DATAOUT_FULL_WIDTH-1:0]  data_int;
  wire[DATAOUT_WIDTH-1:0]       data_out;
  reg [DATAOUT_WIDTH-1:0]       data_out_reg;
  reg [DATAOUT_FULL_WIDTH-1:0]  sampler =  {{1'b0}};
  reg                               val_int =  {{1'b0}};
  wire                              val_out;
  reg                               val_out_reg =  {{1'b0}};
  reg                               act_int [0:N-1];
  reg                               act_samp;
  reg                               act_comb [0:N-1];
  integer                           i,j;
  assign datain_extended = {{(BITGROWTH){data_i[DATAIN_WIDTH-1]}},data_i};
  always @(posedge clk_i)
    if (rst_i)
      for (i=0; i<N; i=i+1) begin
        integrator[i] <= {{1'b0}};
        act_int[i] <= {{1'b0}};
      end
    else if (en_i) begin
      if (act_i) begin
        integrator[0] <= integrator[0] + datain_extended;
        act_int[0] <= 1'b1;
        for (i=1; i<N; i=i+1) begin
          integrator[i] <= integrator[i] + integrator[i-1];
          act_int[i] <= act_int[i-1];
        end
      end
      else begin
        if (act_out_i) begin
          act_int[N-1] <= 1'b0;
        end
      end
    end
  always @(posedge clk_i) begin
    if (rst_i) begin
      sampler <= {{1'b0}};
      for (i=0; i<N; i=i+1) begin
        pipe[i] <= {{1'b0}};
        act_comb[i] <= {{1'b0}};
        for (j=0; j<M; j=j+1)
          diffdelay[i][j] <= {{1'b0}};
      end
      act_samp <= 1'b0;
      val_int <= 1'b0;
    end
    else begin
      if (en_i) begin
        if (act_out_i && act_int[N-1]) begin
           sampler <= integrator[N-1];
           act_samp <= 1'b1;
           diffdelay[0][0] <= sampler;
           for (j=1; j<M; j=j+1)
             diffdelay[0][j] <= diffdelay[0][j-1];
           pipe[0] <= sampler - diffdelay[0][M-1];
           act_comb[0] <= act_samp;
           for (i=1; i<N; i=i+1) begin
             diffdelay[i][0] <= pipe[i-1];
             for (j=1; j<M; j=j+1)
               diffdelay[i][j] <= diffdelay[i][j-1];
             pipe[i] <= pipe[i-1] - diffdelay[i][M-1];
             act_comb[i] <= act_comb[i-1];
           end
           if(N==1)
             val_int <= act_samp;
           else
             val_int <= act_comb[N-2]; 
        end 
        else begin
          val_int <= 1'b0;
        end 
      end 
    end 
  end 
  assign data_int = pipe[N-1];
  generate
    if (DATAOUT_EXTRA_BITS==0) begin
      assign data_out = data_int[DATAOUT_FULL_WIDTH-1:0];
    end
    else if (DATAOUT_EXTRA_BITS > 0) begin
      if (ROUND_CONVERGENT) begin
        assign data_out = data_int[DATAOUT_FULL_WIDTH-1:DATAOUT_EXTRA_BITS] +
            ((data_int[DATAOUT_EXTRA_BITS-1:0] == {1'b1, {(DATAOUT_EXTRA_BITS-1){1'b0}}}) ?
               data_int[DATAOUT_EXTRA_BITS] : data_int[DATAOUT_EXTRA_BITS-1]);
      end
      else begin
        assign data_out = data_int[DATAOUT_FULL_WIDTH-1:DATAOUT_EXTRA_BITS];
      end
    end
    else begin 
      assign data_out = {{(DATAOUT_WIDTH-DATAOUT_FULL_WIDTH){data_int[DATAOUT_FULL_WIDTH-1]}}, data_int};
    end
  endgenerate
  assign val_out = val_int;
  always @(posedge clk_i) begin
    if (rst_i) begin
      data_out_reg <= {{1'b0}};
      val_out_reg <= {{1'b0}};
    end
    else begin
      if (en_i) begin
        data_out_reg <= data_out;
        val_out_reg <= val_out;
      end
    end
  end
  assign data_o = data_out_reg;
  assign val_o = val_out_reg;
endmodule