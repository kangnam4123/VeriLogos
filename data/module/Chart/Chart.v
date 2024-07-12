module Chart
          (
           CLK_IN,
           reset,
           enb,
           CounterMax,
           count
          );
  input   CLK_IN;
  input   reset;
  input   enb;
  input   [15:0] CounterMax;  
  output  [15:0] count;  
  parameter IN_COUNT_Down = 0, IN_COUNT_UP = 1;
  reg [1:0] is_libPwmCompareToPinsHdl_c1_Chart;  
  reg [15:0] count_reg;  
  reg [1:0] is_libPwmCompareToPinsHdl_c1_Chart_next;  
  reg [15:0] count_reg_next;  
  reg [16:0] add_temp_1;  
  reg signed [16:0] sub_temp_1;  
  always @(posedge CLK_IN)
    begin : libPwmCompareToPinsHdl_c1_Chart_process
      if (reset == 1'b1) begin
        count_reg <= 16'd0;
        is_libPwmCompareToPinsHdl_c1_Chart <= IN_COUNT_UP;
      end
      else if (enb) begin
        is_libPwmCompareToPinsHdl_c1_Chart <= is_libPwmCompareToPinsHdl_c1_Chart_next;
        count_reg <= count_reg_next;
      end
    end
  always @(is_libPwmCompareToPinsHdl_c1_Chart, CounterMax, count_reg) begin
    is_libPwmCompareToPinsHdl_c1_Chart_next = is_libPwmCompareToPinsHdl_c1_Chart;
    count_reg_next = count_reg;
    case ( is_libPwmCompareToPinsHdl_c1_Chart)
      IN_COUNT_Down :
        begin
          if (count_reg <= 16'b0000000000000000) begin
            is_libPwmCompareToPinsHdl_c1_Chart_next = IN_COUNT_UP;
          end
          else begin
            sub_temp_1 = $signed({1'b0, count_reg}) - 1;
            if (sub_temp_1[16] == 1'b1) begin
              count_reg_next = 16'b0000000000000000;
            end
            else begin
              count_reg_next = sub_temp_1[15:0];
            end
          end
        end
      default :
        begin
          if (count_reg >= CounterMax) begin
            is_libPwmCompareToPinsHdl_c1_Chart_next = IN_COUNT_Down;
          end
          else begin
            add_temp_1 = count_reg + 1;
            if (add_temp_1[16] != 1'b0) begin
              count_reg_next = 16'b1111111111111111;
            end
            else begin
              count_reg_next = add_temp_1[15:0];
            end
          end
        end
    endcase
  end
  assign count = count_reg_next;
endmodule