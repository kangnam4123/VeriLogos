module soc_system_lcd_16207_0 (
                                 address,
                                 begintransfer,
                                 clk,
                                 read,
                                 reset_n,
                                 write,
                                 writedata,
                                 LCD_E,
                                 LCD_RS,
                                 LCD_RW,
                                 LCD_data,
                                 readdata
                              )
;
  output           LCD_E;
  output           LCD_RS;
  output           LCD_RW;
  inout   [  7: 0] LCD_data;
  output  [  7: 0] readdata;
  input   [  1: 0] address;
  input            begintransfer;
  input            clk;
  input            read;
  input            reset_n;
  input            write;
  input   [  7: 0] writedata;
  wire             LCD_E;
  wire             LCD_RS;
  wire             LCD_RW;
  wire    [  7: 0] LCD_data;
  wire    [  7: 0] readdata;
  assign LCD_RW = address[0];
  assign LCD_RS = address[1];
  assign LCD_E = read | write;
  assign LCD_data = (address[0]) ? {8{1'bz}} : writedata;
  assign readdata = LCD_data;
endmodule