module clock_1_master_FSM (
                             master_clk,
                             master_reset_n,
                             master_waitrequest,
                             slave_read_request_token,
                             slave_write_request_token,
                             master_read,
                             master_read_done,
                             master_write,
                             master_write_done
                          )
;
  output           master_read;
  output           master_read_done;
  output           master_write;
  output           master_write_done;
  input            master_clk;
  input            master_reset_n;
  input            master_waitrequest;
  input            slave_read_request_token;
  input            slave_write_request_token;
  reg              master_read;
  reg              master_read_done;
  reg     [  2: 0] master_state;
  reg              master_write;
  reg              master_write_done;
  reg              next_master_read;
  reg              next_master_read_done;
  reg     [  2: 0] next_master_state;
  reg              next_master_write;
  reg              next_master_write_done;
  always @(posedge master_clk or negedge master_reset_n)
    begin
      if (master_reset_n == 0)
          master_read_done <= 0;
      else if (1)
          master_read_done <= next_master_read_done;
    end
  always @(posedge master_clk or negedge master_reset_n)
    begin
      if (master_reset_n == 0)
          master_write_done <= 0;
      else if (1)
          master_write_done <= next_master_write_done;
    end
  always @(posedge master_clk or negedge master_reset_n)
    begin
      if (master_reset_n == 0)
          master_read <= 0;
      else if (1)
          master_read <= next_master_read;
    end
  always @(posedge master_clk or negedge master_reset_n)
    begin
      if (master_reset_n == 0)
          master_write <= 0;
      else if (1)
          master_write <= next_master_write;
    end
  always @(posedge master_clk or negedge master_reset_n)
    begin
      if (master_reset_n == 0)
          master_state <= 3'b001;
      else if (1)
          master_state <= next_master_state;
    end
  always @(master_read or master_read_done or master_state or master_waitrequest or master_write or master_write_done or slave_read_request_token or slave_write_request_token)
    begin
      case (master_state) 
          3'b001: begin
              if (slave_read_request_token)
                begin
                  next_master_state <= 3'b010;
                  next_master_read <= 1;
                  next_master_write <= 0;
                end
              else if (slave_write_request_token)
                begin
                  next_master_state <= 3'b100;
                  next_master_read <= 0;
                  next_master_write <= 1;
                end
              else 
                begin
                  next_master_state <= master_state;
                  next_master_read <= 0;
                  next_master_write <= 0;
                end
              next_master_read_done <= master_read_done;
              next_master_write_done <= master_write_done;
          end 
          3'b010: begin
              if (!master_waitrequest)
                begin
                  next_master_state <= 3'b001;
                  next_master_read_done <= !master_read_done;
                  next_master_read <= 0;
                end
              else 
                begin
                  next_master_state <= 3'b010;
                  next_master_read_done <= master_read_done;
                  next_master_read <= master_read;
                end
              next_master_write_done <= master_write_done;
              next_master_write <= 0;
          end 
          3'b100: begin
              if (!master_waitrequest)
                begin
                  next_master_state <= 3'b001;
                  next_master_write <= 0;
                  next_master_write_done <= !master_write_done;
                end
              else 
                begin
                  next_master_state <= 3'b100;
                  next_master_write <= master_write;
                  next_master_write_done <= master_write_done;
                end
              next_master_read_done <= master_read_done;
              next_master_read <= 0;
          end 
          default: begin
              next_master_state <= 3'b001;
              next_master_write <= 0;
              next_master_write_done <= master_write_done;
              next_master_read <= 0;
              next_master_read_done <= master_read_done;
          end 
      endcase 
    end
endmodule