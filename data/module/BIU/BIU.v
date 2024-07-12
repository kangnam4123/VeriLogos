module BIU(
input wire clk,
input wire rst,
 input  wire      wb_d_ack_i, 
 input  wire      wb_d_err_i, 
 input  wire      wb_d_rty_i, 
 input  wire [31:0]       wb_d_dat_i, 
 output reg      wb_d_cyc_o, 
 output reg [31:0]      wb_d_adr_o, 
 output reg      wb_d_stb_o, 
 output reg      wb_d_we_o,  
 output reg [3:0]       wb_d_sel_o, 
 output reg [31:0]      wb_d_dat_o, 
 input  wire      wb_c_ack_i, 
 input  wire      wb_c_err_i, 
 input  wire      wb_c_rty_i, 
 input  wire [7:0]       wb_c_dat_i, 
 output reg [31:0]      wb_c_adr_o, 
 output reg      wb_c_stb_o, 
 output reg      wb_c_we_o,  
 output reg [7:0]      wb_c_dat_o, 
input wire Cpu_mem_w_i,
input wire [31:0] Cpu_data2bus_i,                                   
input wire Cpu_req_i,
input wire [31:0] Cpu_addr_bus_i,
output reg [31:0] Cpu_data4bus_o,
output reg Cpu_ready_o,
output reg MIO_mem_w_o,
output reg [31:0] MIO_data2bus_o,                                   
output reg [31:0] MIO_addr_bus_o,
input wire [31:0] MIO_data4bus_i,
input wire MIO_ready_i,
output reg txt_ena,
output reg txt_wea,
output reg [12:0] txt_addra,
input wire [15:0] txt_dina,
output reg [15:0] txt_douta,
output reg [31:0] gpu_status
    );
always @(*) begin
    MIO_data2bus_o   <= Cpu_data2bus_i;
    wb_d_dat_o       <= Cpu_data2bus_i;
    wb_c_dat_o       <= Cpu_data2bus_i;
    txt_douta        <= Cpu_data2bus_i;
    MIO_addr_bus_o   <= Cpu_addr_bus_i;
    wb_d_adr_o       <= Cpu_addr_bus_i;
    wb_c_adr_o       <= Cpu_addr_bus_i;
    txt_addra        <= Cpu_addr_bus_i;
end
always @(*) begin
    wb_d_sel_o <= 4'b1111;
end
always @(*) begin
    MIO_mem_w_o      <= 0;
    wb_d_we_o        <= 0;
    wb_c_we_o        <= 0;
    txt_wea          <= 0;
    wb_d_cyc_o       <= 0;
    wb_d_stb_o       <= 0;
    wb_c_stb_o       <= 0;
    txt_ena          <= 0;
    Cpu_data4bus_o <= 0;
    Cpu_ready_o    <= 0;
    case(Cpu_addr_bus_i[31:28])
        4'h3: begin
            wb_d_we_o        <= Cpu_mem_w_i;
            Cpu_data4bus_o   <= wb_d_dat_i;
            Cpu_ready_o      <= wb_d_ack_i;
            wb_d_cyc_o       <= Cpu_req_i;
            wb_d_stb_o       <= Cpu_req_i;
        end
        4'hb: if (Cpu_addr_bus_i[27]) begin
            Cpu_data4bus_o   <= gpu_status;
            Cpu_ready_o      <= 1'b1;
        end else begin
            txt_wea          <= Cpu_mem_w_i;
            Cpu_data4bus_o   <= txt_dina;
            Cpu_ready_o      <= 1'b1;
            txt_ena          <= Cpu_req_i;
        end
        4'hc: begin
            wb_c_we_o        <= Cpu_mem_w_i;
            Cpu_data4bus_o   <= wb_c_dat_i;
            Cpu_ready_o      <= wb_c_ack_i;
            wb_c_stb_o       <= Cpu_req_i;
        end
        default: begin
            MIO_mem_w_o    <= Cpu_mem_w_i;
            Cpu_data4bus_o <= MIO_data4bus_i;
            Cpu_ready_o    <= MIO_ready_i;
        end
    endcase
end
always @(posedge clk or posedge rst) begin
    if(rst) begin
        gpu_status <= 0;
    end else if(Cpu_addr_bus_i[31:28] == 4'hb && Cpu_addr_bus_i[27] && Cpu_req_i && Cpu_mem_w_i) begin
        gpu_status <= Cpu_data2bus_i;
    end
end
endmodule