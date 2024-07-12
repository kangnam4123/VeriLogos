module clock_gen (
                  clk,
                  reset,
                  frequency,
                  clk_out
                  );
parameter DDS_PRESCALE_NDIV_PP = 5;    
parameter DDS_PRESCALE_BITS_PP = 3;
parameter DDS_BITS_PP  = 6;
input clk;
input reset;
input[DDS_BITS_PP-2:0] frequency;
output clk_out;
wire pulse;
wire dds_clk;
wire [DDS_BITS_PP-2:0] dds_phase_increment = frequency; 
reg delayed_pulse;
reg [DDS_PRESCALE_BITS_PP-1:0] dds_prescale_count;
reg [DDS_BITS_PP-1:0] dds_phase;
always @(posedge clk)
begin
  if (reset) dds_prescale_count <= 0;
  else if (dds_prescale_count == (DDS_PRESCALE_NDIV_PP-1))
    dds_prescale_count <= 0;
  else dds_prescale_count <= dds_prescale_count + 1;
end
assign dds_clk = (dds_prescale_count == (DDS_PRESCALE_NDIV_PP-1));
always @(posedge clk)
begin
  if (reset) dds_phase <= 0;
  else if (dds_clk) dds_phase <= dds_phase + dds_phase_increment;
end
assign pulse = dds_phase[DDS_BITS_PP-1]; 
always @(posedge clk)
begin
  delayed_pulse <= pulse;
end
assign clk_out = (pulse && ~delayed_pulse);  
endmodule