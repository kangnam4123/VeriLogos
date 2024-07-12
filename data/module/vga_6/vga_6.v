module vga_6(input vclock,
            output reg [9:0] hcount,  
            output reg [9:0] vcount,  
            output reg vsync,hsync,blank);
parameter VGA_HBLANKON  =  10'd639;
parameter VGA_HSYNCON   =  10'd655;
parameter VGA_HSYNCOFF  =  10'd751;
parameter VGA_HRESET    =  10'd799;
parameter VGA_VBLANKON  =  10'd479;
parameter VGA_VSYNCON   =  10'd490;
parameter VGA_VSYNCOFF  =  10'd492;
parameter VGA_VRESET    =  10'd523;
reg hblank,vblank;
wire hsyncon,hsyncoff,hreset,hblankon;
assign hblankon = (hcount == VGA_HBLANKON);
assign hsyncon = (hcount == VGA_HSYNCON);
assign hsyncoff = (hcount == VGA_HSYNCOFF);
assign hreset = (hcount == VGA_HRESET);
wire vsyncon,vsyncoff,vreset,vblankon;
assign vblankon = hreset & (vcount == VGA_VBLANKON);
assign vsyncon = hreset & (vcount == VGA_VSYNCON);
assign vsyncoff = hreset & (vcount == VGA_VSYNCOFF);
assign vreset = hreset & (vcount == VGA_VRESET);
wire next_hblank,next_vblank;
assign next_hblank = hreset ? 0 : hblankon ? 1 : hblank;
assign next_vblank = vreset ? 0 : vblankon ? 1 : vblank;
always @(posedge vclock) begin
    hcount <= hreset ? 0 : hcount + 1;
    hblank <= next_hblank;
    hsync <= hsyncon ? 0 : hsyncoff ? 1 : hsync;  
    vcount <= hreset ? (vreset ? 0 : vcount + 1) : vcount;
    vblank <= next_vblank;
    vsync <= vsyncon ? 0 : vsyncoff ? 1 : vsync;  
    blank <= next_vblank | (next_hblank & ~hreset);
end
endmodule