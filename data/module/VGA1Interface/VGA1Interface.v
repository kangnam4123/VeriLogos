module VGA1Interface(clock,reset,framebuffer,vga_hsync,vga_vsync,vga_r,vga_g,vga_b);
   input wire         clock;
   input wire         reset;
   input wire [63:0]  framebuffer;
   output wire        vga_hsync;
   output wire        vga_vsync;
   output wire        vga_r;
   output wire        vga_g;
   output wire        vga_b;
   reg [9:0]          CounterX;
   reg [8:0]          CounterY;
   wire               value;
   reg                clock2 = 0;
   always @ (posedge clock) begin
      if (reset) begin
         clock2 = 0;
      end
      else begin
         clock2 = ~clock2;
      end
   end
   reg         vga_HS;
   reg         vga_VS;
   wire        inDisplayArea = CounterX < 640 && CounterY < 480;
   wire        CounterXmaxed = (CounterX==767);
   always @ (posedge clock2) begin
      if(CounterXmaxed) begin
         CounterX <= 0;
      end
      else begin
         CounterX <= CounterX + 1;
      end
   end
   always @ (posedge clock2) begin
      if(CounterXmaxed) begin
         CounterY <= CounterY + 1;
      end
   end
   always @ (posedge clock2) begin
      vga_HS <= (CounterX[9:4]==0);
      vga_VS <= (CounterY==0);
   end
   assign vga_hsync = ~vga_HS;
   assign vga_vsync = ~vga_VS;
   reg [2:0] ix;
   reg [2:0] iy;
   always @ (posedge clock2) begin
      if (CounterX < 80) begin
         ix = 0;
      end
      else if (CounterX < 160) begin
         ix = 1;
      end
      else if (CounterX < 240) begin
         ix = 2;
      end
      else if (CounterX < 320) begin
         ix = 3;
      end
      else if (CounterX < 400) begin
         ix = 4;
      end
      else if (CounterX < 480) begin
         ix = 5;
      end
      else if (CounterX < 560) begin
         ix = 6;
      end
      else if (CounterX < 640) begin
         ix = 7;
      end
   end 
   always @ (posedge clock2) begin
      if (CounterY < 60) begin
         iy = 0;
      end
      else if (CounterY < 120) begin
         iy = 1;
      end
      else if (CounterY < 180) begin
         iy = 2;
      end
      else if (CounterY < 240) begin
         iy = 3;
      end
      else if (CounterY < 300) begin
         iy = 4;
      end
      else if (CounterY < 360) begin
         iy = 5;
      end
      else if (CounterY < 420) begin
         iy = 6;
      end
      else if (CounterY < 480) begin
         iy = 7;
      end
   end 
   assign value = framebuffer[{iy,ix}];
   assign vga_r = value & inDisplayArea;
   assign vga_g = value & inDisplayArea;
   assign vga_b = value & inDisplayArea;
endmodule