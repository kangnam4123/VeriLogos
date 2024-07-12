module altera_onchip_flash_address_write_protection_check (
    use_sector_addr,
    address,
    write_protection_mode,
    is_addr_writable
);
    parameter FLASH_ADDR_WIDTH = 23;
    parameter SECTOR1_START_ADDR = 1;
    parameter SECTOR1_END_ADDR = 1;
    parameter SECTOR2_START_ADDR = 1;
    parameter SECTOR2_END_ADDR = 1;
    parameter SECTOR3_START_ADDR = 1;
    parameter SECTOR3_END_ADDR = 1;
    parameter SECTOR4_START_ADDR = 1;
    parameter SECTOR4_END_ADDR = 1;
    parameter SECTOR5_START_ADDR = 1;
    parameter SECTOR5_END_ADDR = 1;
    parameter SECTOR_READ_PROTECTION_MODE = 5'b11111;
    input use_sector_addr;
    input [FLASH_ADDR_WIDTH-1:0] address;
    input [4:0] write_protection_mode;
    output is_addr_writable;
    wire is_sector1_addr;
    wire is_sector2_addr;
    wire is_sector3_addr;
    wire is_sector4_addr;
    wire is_sector5_addr;    
    wire is_sector1_writable;
    wire is_sector2_writable;
    wire is_sector3_writable;
    wire is_sector4_writable;
    wire is_sector5_writable;
    assign is_sector1_addr = (use_sector_addr) ? (address == 1) : ((address >= SECTOR1_START_ADDR) && (address <= SECTOR1_END_ADDR));
    assign is_sector2_addr = (use_sector_addr) ? (address == 2) : ((address >= SECTOR2_START_ADDR) && (address <= SECTOR2_END_ADDR));
    assign is_sector3_addr = (use_sector_addr) ? (address == 3) : ((address >= SECTOR3_START_ADDR) && (address <= SECTOR3_END_ADDR));
    assign is_sector4_addr = (use_sector_addr) ? (address == 4) : ((address >= SECTOR4_START_ADDR) && (address <= SECTOR4_END_ADDR));
    assign is_sector5_addr = (use_sector_addr) ? (address == 5) : ((address >= SECTOR5_START_ADDR) && (address <= SECTOR5_END_ADDR));
    assign is_sector1_writable = ~(write_protection_mode[0] || SECTOR_READ_PROTECTION_MODE[0]);
    assign is_sector2_writable = ~(write_protection_mode[1] || SECTOR_READ_PROTECTION_MODE[1]);
    assign is_sector3_writable = ~(write_protection_mode[2] || SECTOR_READ_PROTECTION_MODE[2]);
    assign is_sector4_writable = ~(write_protection_mode[3] || SECTOR_READ_PROTECTION_MODE[3]);
    assign is_sector5_writable = ~(write_protection_mode[4] || SECTOR_READ_PROTECTION_MODE[4]);
    assign is_addr_writable = ((is_sector1_writable && is_sector1_addr) ||
                               (is_sector2_writable && is_sector2_addr) ||
                               (is_sector3_writable && is_sector3_addr) ||
                               (is_sector4_writable && is_sector4_addr) ||
                               (is_sector5_writable && is_sector5_addr));
endmodule