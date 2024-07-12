module spi_receive_data (clock, reset, enable, sdi,
                          count, sclk, done, data, spiclockp, spiclockn,
                          picready, starting);
    input clock, spiclockp, spiclockn;
    input reset;
    input [4:0] count;
    input       enable, sdi, picready;
    output      sclk, starting, done;
    output [127:0] data;
    wire   clock;
    wire   enable;
    wire [127:0] data;
    wire [4:0]  count;
    reg         sclk, starting;
    wire        sdi, picready;
    reg [127:0] latch;
    reg [7:0]   left;
    reg         sample, ready, receive_next;
    wire        receiving, done;
    always @(negedge clock or negedge reset)
      if (~reset)
        begin
           ready <= 1;
           left  <= 0;
           starting <= 0;
        end
      else
        begin
           if (spiclockn)
             begin
                sclk     <= 0;
                starting <= 0;
                if (~enable)
                  begin
                     ready <= 1;
                     left  <= 0;
                  end
                else if (ready)
                  begin
                     left         <= {count, 3'b0};
                     ready        <= 0;
                  end
                else if (left > 0 && receive_next)
                  begin
                     latch <= {latch[126:0], sample};
                     left  <= left - 8'd1;
                  end
             end
           else if (spiclockp && receiving)
             if (left[2:0] != 3'b000 | picready)
               begin
                  sample       <= sdi;
                  sclk         <= 1;
                  receive_next <= 1;
                  starting     <= left[2:0] == 3'b000;
               end
             else receive_next <= 0;
        end
    assign done = ~ready & (left == 0);
    assign receiving = ~ready & ~done;
    assign data = latch;
endmodule