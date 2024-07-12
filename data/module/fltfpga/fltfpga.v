module fltfpga(
               input wire           clk,
               input wire           reset_n,
               output wire           hdmi_i2c_clk,
               input wire            hdmi_i2c_data_in,
               output wire           hdmi_i2c_data_out,
               input wire            hdmi_tx_int,
               output wire [23 : 0]  hdmi_tdx,
               output wire           hdmi_tx_clk,
               output wire           hdmi_tx_data_en,
               output wire           hdmi_tx_vsync,
               output wire           hdmi_tx_hsync,
               output wire           hdmi_tx_de,
               input wire           scl_in,
               output wire          scl_out,
               input wire           sda_in,
               output wire          sda_out,
               output wire [7 : 0]   led,
               input wire            button0,
               input wire            button1,
               input wire          uart_rxd,
               output wire         uart_txd
              );
  parameter AUDIO_I2C_ADDR = 8'h42;
  parameter HDMI_I2C_ADDR  = 8'h43;
  always @ (posedge clk)
    begin
      if (!reset_n)
        begin
        end
      else
        begin
        end
    end 
endmodule