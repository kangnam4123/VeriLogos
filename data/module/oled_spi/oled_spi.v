module oled_spi(
  input wire clock,
  input wire reset,
  input wire shutdown,
  output wire cs,
  output reg sdin,
  output wire sclk,
  output reg dc,
  output reg res,
  output reg vbatc,
  output reg vddc
);
  parameter WAIT = 1;
  parameter SEND = 2;  
  parameter SEND2 = 3; 
  parameter SEND3 = 4; 
  parameter SEND4 = 5; 
  parameter STARTUP_1  = 10;
  parameter STARTUP_2  = 11;
  parameter STARTUP_3  = 12;
  parameter STARTUP_4  = 13;
  parameter STARTUP_5  = 14;
  parameter STARTUP_6  = 15;
  parameter STARTUP_7  = 16;
  parameter STARTUP_8  = 17;
  parameter STARTUP_9  = 18;
  parameter SHUTDOWN_1 = 6;
  parameter SHUTDOWN_2 = 7;
  parameter SHUTDOWN_3 = 8;
  reg [31:0] send_buf;
  reg  [4:0] send_idx;
  reg  [1:0] send_ctr;
  reg  [1:0] send_max;
  reg [31:0] wait_ctr;
  reg [31:0] wait_max;
  reg [7:0] state;
  reg [7:0] next_state;
  always @(posedge clock) begin
    if (reset) begin
      send_buf <= 32'b0;
      send_idx <= 5'b0;
      send_ctr <= 2'b0;
      send_max <= 2'b0;
      wait_ctr <= 32'b0;
      wait_max <= 32'b0;
      state <= STARTUP_1;
      next_state <= 1'b0;
      sdin <= 1'b0;
      dc <= 1'b0;
      res <= 1'b1;
      vddc <= 1'b1;
      vbatc <= 1'b1;
    end
    else if (shutdown) begin
      if (state > 0 && state < 10) begin
        next_state <= SHUTDOWN_1;
      end else begin
        state <= SHUTDOWN_1;
      end
    end
    else begin   
      if (state == SEND) begin
        sdin <= send_buf[(7 - send_idx) + (8 * send_ctr)];
        if (send_idx == 7 && send_ctr == send_max) begin
          send_idx <= 0;
          send_ctr <= 0;
          send_max <= 0;
          state <= next_state;
        end else if (send_idx == 7) begin
          send_idx <= 0;
          send_ctr <= send_ctr + 1;
        end else begin
          send_idx <= send_idx + 1;
        end
      end
      if (state == SEND2) begin
        send_max = 1;
        state <= SEND;
      end
      else if (state == SEND3) begin
        send_max = 2;
        state <= SEND;
      end
      else if (state == SEND4) begin
        send_max = 3;
        state <= SEND;
      end
      else if (state == WAIT) begin
        if (wait_ctr == wait_max) begin
          wait_ctr <= 0;
          state <= next_state;
        end else begin
          wait_ctr <= wait_ctr + 1;
        end
      end
      else if (state == STARTUP_1) begin
        dc <= 0;
        vddc <= 0;
        wait_max <= 5000; 
        state <= WAIT;
        next_state <= STARTUP_2;
      end
      else if (state == STARTUP_2) begin
        send_buf <= 8'hAE;
        state <= SEND;
        next_state <= STARTUP_3;
      end
      else if (state == STARTUP_3) begin
        res <= 0;
        wait_max <= 5000; 
        state <= WAIT;
        next_state <= STARTUP_4;
      end
      else if (state == STARTUP_4) begin
        res <= 1;
        send_buf <= 16'h148D;
        state <= SEND2;
        next_state <= STARTUP_5;
      end
      else if (state == STARTUP_5) begin
        send_buf <= 16'hF1D9;
        state <= SEND2;
        next_state <= STARTUP_6;
      end
      else if (state == STARTUP_6) begin
        vbatc <= 0;
        wait_max <= 500000; 
        state <= WAIT;
        next_state <= STARTUP_7;
      end
      else if (state == STARTUP_7) begin
        send_buf <= 16'hC8A1;
        state <= SEND2;
        next_state <= STARTUP_8;
      end
      else if (state == STARTUP_8) begin
        send_buf <= 16'h20DA;
        state <= SEND2;
        next_state <= STARTUP_9;
      end
      else if (state == STARTUP_9) begin
        send_buf <= 8'hAF;
        state <= SEND;
        next_state <= 0; 
      end
      else if (state == SHUTDOWN_1) begin
        send_buf <= 8'hAE;
        state <= SEND;
        next_state <= SHUTDOWN_2;
      end
      else if (state == SHUTDOWN_2) begin
        vbatc <= 1;
        wait_max <= 500000; 
        state <= WAIT;
        next_state <= SHUTDOWN_3;
      end
      else if (state == SHUTDOWN_3) begin
        vddc <= 1;
        state <= 0; 
      end
    end
  end
  assign cs = 0;
  assign sclk = !clock;
endmodule