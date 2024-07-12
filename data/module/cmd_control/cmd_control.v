module cmd_control (clk_host,reset_host, new_command, cmd_argument, cmd_index, ack_in, strobe_in, cmd_in, response, cmd_complete, cmd_index_error, strobe_out, ack_out, idle_out, cmd_out);
    input wire clk_host;
    input wire reset_host;
    input wire new_command;
    input wire [31:0]cmd_argument;
    input wire [5:0]cmd_index;
    input wire ack_in;
    input wire strobe_in;
    input wire [135:0]cmd_in;
    output reg [127:0]response;
    output reg cmd_complete;
    output reg cmd_index_error;
    output reg strobe_out;
    output reg ack_out;
    output reg idle_out;
    output reg [39:0]cmd_out;
    parameter RESET = 0;
    parameter IDLE = 1;
    parameter SETTING_OUTPUTS = 2;
    parameter PROCESSING = 3;
    reg [1:0]estado = 0;
    always @ ( * ) begin
        case (estado)
            RESET: begin
                response = 0;
                cmd_complete = 0;
                cmd_index_error = 0;
                strobe_out = 0;
                ack_out = 0;
                idle_out = 0;
                cmd_out = 0;
                estado = IDLE;
            end
            IDLE: begin
                if (reset_host == 1) begin
                    estado = RESET;
                end else begin
                    if (new_command == 1) begin
                        estado = SETTING_OUTPUTS;
                    end else begin
                        idle_out = 1;
                        estado = IDLE;
                    end
                end
            end
            SETTING_OUTPUTS: begin
                if (reset_host == 1) begin
                    estado = RESET;
                end else begin
                    strobe_out = 1;
                    cmd_out [39] = 0;
                    cmd_out [38] = 1;
                    cmd_out [37:32] = cmd_index;
                    cmd_out [31:0] = cmd_argument;
                    estado = PROCESSING;
                end
            end
            PROCESSING: begin
                if (reset_host == 1) begin
                    estado = RESET;
                end else begin
                    if (strobe_in == 1) begin
                        cmd_complete = 1;
                        ack_out = 1;
                        if ((cmd_out[0] != 1) || (cmd_in[134] != 0)) begin
                            cmd_index_error = 1;
                        end else begin
                            cmd_index_error = 0;
                        end
                        response = cmd_in[135:8];
                        if (ack_in == 1) begin
                            estado = IDLE;
                        end else begin
                            estado = PROCESSING;
                        end
                    end else begin
                        estado = PROCESSING;
                    end
                end
            end
            default: begin
                estado = IDLE;
            end
        endcase
    end
endmodule