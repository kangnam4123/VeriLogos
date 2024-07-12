module packet_router (
    input  wire         clk,            
    input  wire         reset_b,        
    input wire  [07:00] address_port_0, 
    input wire  [07:00] address_port_1, 
    input wire  [07:00] address_port_2, 
    input wire  [07:00] address_port_3, 
    input  wire         data_stall,     
    input  wire         data_valid,     
    input  wire [07:00] data,           
    output reg          ready_0,        
    output reg  [07:00] port0,          
    output reg          ready_1,        
    output reg  [07:00] port1,          
    output reg          ready_2,        
    output reg  [07:00] port2,          
    output reg          ready_3,        
    output reg  [07:00] port3);         
    parameter 
        IDLE              = 1'b0,
        PROCESS_PACKET    = 1'b1;
    reg       state;
    reg       next_state;
    reg [7:0] data_d;
    reg       data_ready;
    reg [7:0] packet_address;
    always @(posedge clk or negedge reset_b) begin
            if (~reset_b) begin
                    state               <= IDLE;
                    data_d              <= 9'h00;
                    data_ready          <= 1'b0;
                    packet_address      <= 8'h00;
                end
            else begin
                    state               <= next_state;
                    data_d              <= data;
                    data_ready          <= data_valid;
                    if (state == IDLE) 
                        packet_address  <= data;
                end
        end
    always @*
        case(state)
            IDLE: 
                if (data_valid & ~data_stall) next_state = PROCESS_PACKET;
                else                          next_state = IDLE;
            PROCESS_PACKET:
                if (data_valid & ~data_stall) next_state = PROCESS_PACKET;
                else if (~data_valid)         next_state = IDLE;
                else                          next_state = PROCESS_PACKET;
        endcase
    always @* begin
        port0   = 8'd0;
        ready_0 = 1'b0;
        port1   = 8'd0;
        ready_1 = 1'b0;
        port2   = 8'd0;
        ready_2 = 1'b0;
        port3   = 8'd0;
        ready_3 = 1'b0;
        case(packet_address)
            address_port_0: begin
                port0   = data_d;
                ready_0 = data_ready;
            end
            address_port_1: begin
                port1   = data_d;
                ready_1 = data_ready;
            end
            address_port_2: begin
                port2   = data_d;
                ready_2 = data_ready;
            end
            address_port_3: begin
                port3   = data_d;
                ready_3 = data_ready;
            end
        endcase
    end
endmodule