module master_updateable_megarom(
  inout wire [7:0] D,
  input wire [16:0] bbc_A,
  output wire [18:0] flash_A,
  output wire flash_nOE,
  output wire flash_nWE,
  input wire cpld_SCK_in,
  input wire cpld_MOSI,
  input wire cpld_SS,
  output reg cpld_MISO,
  input wire [1:0] cpld_JP
);
assign cpld_SCK = cpld_SCK_in;
reg installed_in_bbc_master = 1'b0;
reg [1:0] flash_bank = 2'b0;
wire model_b_A16;
wire bbc_nCE;
reg [18:0] spi_A = 19'b0;
reg [7:0] spi_D = 8'b0;
reg allowing_bbc_access_int = 1'b1;
wire allowing_bbc_access;
reg accessing_memory = 1'b0;
wire reading_memory;
wire writing_memory;
reg rnw = 1'b0;
reg driving_bus = 1'b0;
reg [4:0] spi_bit_count = 5'b0;
assign allowing_bbc_access = allowing_bbc_access_int; 
assign flash_A = (allowing_bbc_access == 1'b1)
                 ? (installed_in_bbc_master
                    ? {flash_bank, bbc_A} 
                    : {flash_bank, model_b_A16, bbc_A[15:0]}) 
                 : spi_A;
assign model_b_A16 = cpld_JP[0];
assign bbc_nCE = installed_in_bbc_master
                 ? 1'b0 
                 : (cpld_JP[0] && cpld_JP[1]); 
assign reading_memory = accessing_memory && rnw;
assign flash_nOE = !((allowing_bbc_access && !bbc_nCE && !bbc_A[16]) 
                     || reading_memory);
assign writing_memory = accessing_memory && !rnw;
assign flash_nWE = !(!allowing_bbc_access && writing_memory);
assign D = (allowing_bbc_access == 1'b0 && (driving_bus == 1'b1 && rnw == 1'b0)) ? spi_D : 8'bZZZZZZZZ;
always @(posedge cpld_SCK or posedge cpld_SS) begin
  if (cpld_SS == 1'b1) begin
    accessing_memory <= 1'b0;
    driving_bus <= 1'b0;
    spi_bit_count <= 6'b000000;
  end else begin
    if (spi_bit_count < 19) begin
      spi_A <= {spi_A[17:0], cpld_MOSI};
    end else if (spi_bit_count == 19) begin
      rnw <= cpld_MOSI;
      allowing_bbc_access_int <= 1'b0;
    end else if (rnw == 1'b1) begin
      if (spi_bit_count == 20) begin
        accessing_memory <= 1'b1;
      end else if (spi_bit_count == 23) begin
        accessing_memory <= 1'b0;
        spi_D <= D;
      end else if (spi_bit_count >= 24) begin
        spi_D <= {spi_D[6:0], 1'b0};
      end
    end else if (rnw == 1'b0) begin
      if (spi_bit_count < 28) begin
        spi_D <= {spi_D[6:0], cpld_MOSI};
        driving_bus <= 1'b1;
      end
      if (spi_bit_count == 28) begin
        accessing_memory <= 1'b1;
      end
      if (spi_bit_count == 30) begin
        accessing_memory <= 1'b0;
      end
    end
    if (spi_bit_count == 31) begin
      driving_bus <= 1'b0;
      allowing_bbc_access_int <= cpld_MOSI;
    end
    spi_bit_count <= spi_bit_count + 1;
  end
end
always @(negedge cpld_SCK) begin
  if (spi_bit_count < 19) begin
    cpld_MISO <= spi_bit_count[0];  
  end else begin
    cpld_MISO <= spi_D[7];
  end
end
endmodule