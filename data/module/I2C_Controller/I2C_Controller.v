module I2C_Controller (
	clk,
    nreset,
	I2C_SCLK, 
 	I2C_SDAT_OUT, 
    I2C_SDAT_IN,
	I2C_DATA, 
	GO,       
	END,      
	W_R,      
	ACK,      
    ACTIVE
);
parameter     clk_freq_khz = 50000;	
parameter     i2c_freq_khz = 20;    
parameter     i2c_clks_per_bit = (clk_freq_khz / i2c_freq_khz)-1;
input         clk;
input         nreset;
input  [23:0] I2C_DATA;	
input         GO;	
input         W_R;	
output        END;	
output        ACK;
output        ACTIVE;
output        I2C_SDAT_OUT;
input         I2C_SDAT_IN;
output        I2C_SCLK;
reg           SDO;
reg           SCLK;
reg    [11:0] i2c_clk_count;
reg           i2c_clk_last;
reg           END;
reg    [23:0] SD;
reg    [ 5:0] SD_COUNTER;
reg           ACK1;
reg           ACK2;
reg           ACK3;
reg           ACTIVE;
wire          i2c_clk      = (i2c_clk_count > (i2c_clks_per_bit/2)) ? 1'b1 : 1'b0;
wire          i2c_clk_rise = i2c_clk & ~i2c_clk_last;
assign        I2C_SCLK     = SCLK | (((SD_COUNTER >= 4) && (SD_COUNTER <= 30)) ? ~i2c_clk : 1'b0);
assign        I2C_SDAT_OUT = SDO;
assign        ACK          = ~(ACK1 | ACK2 | ACK3);
always @(posedge clk or negedge nreset)
begin
  if (nreset == 1'b0)
  begin
    i2c_clk_count <= {12{1'b0}};
    i2c_clk_last  <= 1'b0;
  end
  else
  begin
    i2c_clk_last <= i2c_clk;
    if (i2c_clk_count < i2c_clks_per_bit)
    begin
      i2c_clk_count <= i2c_clk_count + 12'd1;
    end
    else
    begin
      i2c_clk_count <= {12{1'b0}};
    end
  end
end
always @(posedge clk or negedge nreset) 
begin
  if (nreset == 1'b0)
  begin 
    SCLK       <= 1'b1;
    SDO        <= 1'b1; 
    ACK1       <= 1'b0;
    ACK2       <= 1'b0;
    ACK3       <= 1'b0; 
    END        <= 1'b1;
    ACTIVE     <= 1'b0;
    SD_COUNTER <= 6'h3f;
  end
  else
  begin
    ACTIVE <= ACTIVE | GO;
    if (i2c_clk_rise)
    begin
      if (GO == 1'b0)
      begin
        SD_COUNTER <= 6'h00;
      end
      else
      begin      
        if (SD_COUNTER < 6'h3f)
        begin
          SD_COUNTER <= SD_COUNTER + 6'h01;
        end
      end
      case (SD_COUNTER)
	  6'd0 : 
      begin 
        ACK1   <= 1'b0;
        ACK2   <= 1'b0;
        ACK3   <= 1'b0;
        END    <= 1'b0;
        SDO    <= 1'b1;
        SCLK   <= 1'b1;
        ACTIVE <= ACTIVE & ~END;
      end
	  6'd1 : 
      begin 
        SD  <= I2C_DATA;
        SDO <= 0;
      end
	  6'd2 : SCLK = 1'b0;
	  6'd3 : SDO <= SD[23];
	  6'd4 : SDO <= SD[22];
	  6'd5 : SDO <= SD[21];
	  6'd6 : SDO <= SD[20];
	  6'd7 : SDO <= SD[19];
	  6'd8 : SDO <= SD[18];
	  6'd9 : SDO <= SD[17];
	  6'd10: SDO <= SD[16];	
	  6'd11: SDO <= 1'b1;
	  6'd12: 
      begin 
        SDO  = SD[15]; 
        ACK1 = I2C_SDAT_IN;
      end
	  6'd13: SDO <= SD[14];
	  6'd14: SDO <= SD[13];
	  6'd15: SDO <= SD[12];
	  6'd16: SDO <= SD[11];
	  6'd17: SDO <= SD[10];
	  6'd18: SDO <= SD[9];
	  6'd19: SDO <= SD[8];
	  6'd20: SDO <= 1'b1;
	  6'd21:
      begin 
        SDO  <= SD[7];
        ACK2 <= I2C_SDAT_IN;
      end
	  6'd22: SDO <= SD[6];
	  6'd23: SDO <= SD[5];
	  6'd24: SDO <= SD[4];
	  6'd25: SDO <= SD[3];
	  6'd26: SDO <= SD[2];
	  6'd27: SDO <= SD[1];
	  6'd28: SDO <= SD[0];
	  6'd29: SDO <= 1'b1;
      6'd30 :
      begin 
        SDO  <= 1'b0;
        SCLK <= 1'b0;
        ACK3 <= I2C_SDAT_IN;
      end	
      6'd31: SCLK <= 1'b1; 
      6'd32:
      begin
        SDO <= 1'b1;
        END <= 1'b1; 
      end 
      endcase
    end
  end
end
endmodule