module gpio_bit (
   gpio_data_in,
   gpio,
   clk, gpio_oen, gpio_data_out
   ) ;
   input clk;           
   input gpio_oen;
   input gpio_data_out;
   output gpio_data_in;
   inout  gpio;
   wire   gpio_data_in;
   wire   temp;
   assign gpio = (gpio_oen) ? gpio_data_out : 1'bz;
   assign gpio_data_in = (!gpio_oen) ? gpio : 1'bz;
endmodule