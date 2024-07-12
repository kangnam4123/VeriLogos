module control_capa_fisica (strobe_in, ack_in, idle_in, pad_response, reception_complete, transmission_complete, ack_out, strobe_out, response, load_send, enable_stp, enable_pts, reset_stp, reset_pts, reset_host, clk_SD);
    input wire strobe_in, ack_in, idle_in, reset_host, clk_SD;
    input wire [135:0]pad_response;
    input wire reception_complete, transmission_complete;
    output reg ack_out, strobe_out;
    output reg [135:0]response;
    output reg load_send, enable_stp, enable_pts, reset_stp, reset_pts;
    parameter RESET = 0;
    parameter IDLE = 1;
    parameter SEND_COMMAND = 2;
    parameter WAIT_RESPONSE = 3;
    parameter SEND_RESPONSE = 4;
    parameter WAIT_ACK = 5;
    parameter SEND_ACK = 6;
    reg [2:0] estado = 0;
    reg [5:0]cuenta_wait_response = 0;
    always @ ( * ) begin
        case (estado)
            RESET: begin
                ack_out = 0;
                strobe_out = 0;
                response = 0;
                load_send = 0;
                enable_stp = 0;
                enable_pts = 0;
                reset_stp = 0;
                reset_pts = 0;
                estado = IDLE;
            end
            IDLE: begin
                if (reset_host == 1) begin
                    estado = RESET;
                end else begin
                    reset_stp = 1;
                    reset_pts = 1;
                    if (strobe_in == 1) begin
                        estado = SEND_COMMAND;
                    end else begin
                        estado = IDLE;
                    end
                end
            end
            SEND_COMMAND: begin
                if (reset_host == 1) begin
                    estado = RESET;
                end else begin
                    if (idle_in == 1) begin
                        estado = IDLE;
                    end else begin
                        enable_pts = 1;
                        load_send = 1;
                        if (transmission_complete == 1) begin
                            estado = WAIT_RESPONSE;
                        end else begin
                            estado = SEND_COMMAND;
                        end
                    end
                end
            end
            WAIT_RESPONSE: begin
                if (reset_host == 1) begin
                    estado = RESET;
                end else begin
                    if (idle_in == 1) begin
                        estado = IDLE;
                    end else begin
                        if (cuenta_wait_response == 63) begin
                            estado = reset_host;
                        end else begin
                            enable_stp = 1;
                            load_send = 0;
                            if (reception_complete == 1) begin
                                estado = SEND_RESPONSE;
                            end else begin
                                estado = WAIT_RESPONSE;
                            end
                        end
                    end
                end
            end
            SEND_RESPONSE: begin
                if (reset_host == 1) begin
                    estado = RESET;
                end else begin
                    if (idle_in == 1) begin
                        estado = IDLE;
                    end else begin
                        response = pad_response;
                        strobe_out = 1;
                        estado = WAIT_ACK;
                    end
                end
            end
            WAIT_ACK: begin
                if (reset_host == 1) begin
                    estado = RESET;
                end else begin
                    if (idle_in == 1) begin
                        estado = IDLE;
                    end else begin
                        if (ack_in == 1) begin
                            estado = SEND_ACK;
                        end else begin
                            ack_out = 0;
                            strobe_out = 0;
                            response = 0;
                            load_send = 0;
                            enable_stp = 0;
                            enable_pts = 0;
                            reset_stp = 0;
                            reset_pts = 0;
                            estado = WAIT_ACK;
                        end
                    end
                end
            end
            SEND_ACK: begin
                ack_out = 1;
                estado = IDLE;
            end
            default: begin
                estado = IDLE;
            end
        endcase
    end
endmodule