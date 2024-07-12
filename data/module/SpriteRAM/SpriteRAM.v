module SpriteRAM(input clk, input ce,
                 input reset_line,          
                 input sprites_enabled,     
                 input exiting_vblank,      
                 input obj_size,            
                 input [8:0] scanline,      
                 input [8:0] cycle,         
                 output reg [7:0] oam_bus,  
                 input oam_ptr_load,        
                 input oam_load,            
                 input [7:0] data_in,       
                 output reg spr_overflow,   
                 output reg sprite0);       
  reg [7:0] sprtemp[0:31];   
  reg [7:0] oam[0:255];      
  reg [7:0] oam_ptr;         
  reg [2:0] p;               
  reg [1:0] state;           
  wire [7:0] oam_data = oam[oam_ptr];
  reg [4:0] sprtemp_ptr;
  wire [8:0] spr_y_coord = scanline - {1'b0, oam_data};
  wire spr_is_inside = (spr_y_coord[8:4] == 0) && (obj_size || spr_y_coord[3] == 0);
  reg [7:0] new_oam_ptr;     
  reg [1:0] oam_inc;         
  reg sprite0_curr;          
  reg oam_wrapped;           
  wire [7:0] sprtemp_data = sprtemp[sprtemp_ptr];
  always @*  begin
    case({cycle[8], cycle[2]}) 
    2'b0_?: sprtemp_ptr = {p, oam_ptr[1:0]};
    2'b1_0: sprtemp_ptr = {cycle[5:3], cycle[1:0]}; 
    2'b1_1: sprtemp_ptr = {cycle[5:3], 2'b11};      
    endcase
  end
  always @* begin
    case({sprites_enabled, cycle[8], cycle[6], state, oam_ptr[1:0]})
    7'b1_10_??_??: oam_bus = sprtemp_data;         
    7'b1_??_00_??: oam_bus = 8'b11111111;                  
    7'b1_??_01_00: oam_bus = {4'b0000, spr_y_coord[3:0]};  
    7'b?_??_??_10: oam_bus = {oam_data[7:5], 3'b000, oam_data[1:0]}; 
    default:       oam_bus = oam_data;                     
    endcase
  end
  always @* begin
    case ({oam_load, state, oam_ptr[1:0]})
    5'b1_??_??: oam_inc = {oam_ptr[1:0] == 3, 1'b1};       
    5'b0_00_??: oam_inc = 2'b01;                           
    5'b0_01_00: oam_inc = {!spr_is_inside, spr_is_inside}; 
    5'b0_01_??: oam_inc = {oam_ptr[1:0] == 3, 1'b1};       
    5'b0_11_??: oam_inc = 2'b11;
    5'b0_10_??: oam_inc = {1'b0, oam_ptr[1:0] != 0};
    endcase
    new_oam_ptr[1:0] = oam_ptr[1:0] + {1'b0, oam_inc[0]};
    {oam_wrapped, new_oam_ptr[7:2]} = {1'b0, oam_ptr[7:2]} + {6'b0, oam_inc[1]};
  end
  always @(posedge clk) if (ce) begin
    if (oam_load)
      oam[oam_ptr] <= (oam_ptr & 3) == 2 ? data_in & 8'hE3: data_in;
    if (cycle[0] && sprites_enabled || oam_load || oam_ptr_load) begin
      oam_ptr <= oam_ptr_load ? data_in : new_oam_ptr;
    end
    if (sprites_enabled && state == 2'b11 && spr_is_inside)
      spr_overflow <= 1;
    sprite0_curr <= (state == 2'b01 && oam_ptr[7:2] == 0 && spr_is_inside || sprite0_curr);
    if (!state[1]) sprtemp[sprtemp_ptr] <= oam_bus;
    if (cycle[0]) begin
      if (!state[1] && oam_ptr[1:0] == 2'b11) p <= p + 1;
      case({state, (p == 7) && (oam_ptr[1:0] == 2'b11), oam_wrapped})
      4'b00_0_?: state <= 2'b00;  
      4'b00_1_?: state <= 2'b01;  
      4'b01_?_1: state <= 2'b10;  
      4'b01_1_0: state <= 2'b11;  
      4'b01_0_0: state <= 2'b01;  
      4'b11_?_1: state <= 2'b10;  
      4'b11_?_0: state <= 2'b11;  
      4'b10_?_?: state <= 2'b10;  
      endcase
    end
    if (reset_line) begin
      state <= 0;
      p <= 0;
      oam_ptr <= 0;
      sprite0_curr <= 0;
      sprite0 <= sprite0_curr;
    end
    if (exiting_vblank)
      spr_overflow <= 0;
  end
endmodule