module hapara_axis_id_generator_v1_0_M00_AXIS #
    (
        parameter integer C_M_AXIS_TDATA_WIDTH    = 32
    )
    (
        input wire En,
        output wire Finish,
        input wire [C_M_AXIS_TDATA_WIDTH - 1 : 0] org,
        input wire [C_M_AXIS_TDATA_WIDTH - 1 : 0] len,
        input wire [C_M_AXIS_TDATA_WIDTH - 1 : 0] numOfSlv,
        input wire  M_AXIS_ACLK,
        input wire  M_AXIS_ARESETN,
        output wire  M_AXIS_TVALID,
        output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
        output wire  M_AXIS_TLAST,
        input wire  M_AXIS_TREADY
    );
    localparam X_LENGTH = C_M_AXIS_TDATA_WIDTH / 2;
    localparam Y_LENGTH = C_M_AXIS_TDATA_WIDTH / 2;
    localparam LENGTH   = C_M_AXIS_TDATA_WIDTH / 2;
    localparam reset            = 4'b0001; 
    localparam counting         = 4'b0010;
    localparam waitend          = 4'b0100;
    localparam ending           = 4'b1000;
    reg [3 : 0] next_state;
    reg [3 : 0] curr_state;
    reg [X_LENGTH - 1 : 0] counterX;
    reg [Y_LENGTH - 1 : 0] counterY;
    wire [LENGTH - 1 : 0] orgX;
    wire [LENGTH - 1 : 0] orgY;
    wire [LENGTH - 1 : 0] lengthX;
    wire [LENGTH - 1 : 0] lengthY;
    assign orgX     = org[C_M_AXIS_TDATA_WIDTH - 1 : LENGTH];
    assign orgY     = org[LENGTH - 1 : 0];
    assign lengthX  = len[C_M_AXIS_TDATA_WIDTH - 1 : LENGTH];
    assign lengthY  = len[LENGTH - 1 : 0];
    assign Finish = curr_state == ending;
    always @(curr_state or En or slave_counter or M_AXIS_TREADY) begin
        case (curr_state)
            reset:
                if (En) begin
                    next_state = counting;
                end
                else begin
                    next_state = reset;
                end
            counting:
                if (slave_counter == 1) begin
                    next_state = waitend;
                end
                else begin
                    next_state = counting;
                end
            waitend:
                if (M_AXIS_TREADY == 1) begin
                    next_state = ending;
                end
                else begin
                    next_state = waitend;
                end
            ending:
                next_state = reset;
            default:
                next_state = 4'bxxxx;
        endcase
    end
    assign M_AXIS_TVALID = (curr_state == counting || curr_state == ending);
    always @(posedge M_AXIS_ACLK) begin
        if (!M_AXIS_ARESETN) begin
            curr_state <= reset;
        end
        else begin
            curr_state <= next_state;
        end
    end
    always @(posedge M_AXIS_ACLK) begin
        if (!M_AXIS_ARESETN || curr_state == reset) begin
            counterX <= {X_LENGTH{1'b0}};
            counterY <= {Y_LENGTH{1'b0}};
        end
        else if (curr_state == counting || curr_state == ending) begin
            if (M_AXIS_TREADY) begin
                if (counterY >= lengthY - 1 && counterX >= lengthX - 1) begin
                    counterX <= {X_LENGTH{1'b1}};
                    counterY <= {Y_LENGTH{1'b1}};
                end
                else if (counterY >= lengthY - 1) begin
                    counterX <= counterX + 1;
                    counterY <= {Y_LENGTH{1'b0}};
                end
                else begin
                    counterY <= counterY + 1;
                end
            end
        end 
        else begin
            counterX <= counterX;
            counterY <= counterY;
        end 
    end
    reg [C_M_AXIS_TDATA_WIDTH - 1 : 0] slave_counter;
    always @(posedge M_AXIS_ACLK) begin
        if (!M_AXIS_ARESETN || curr_state == reset) begin
            slave_counter <= 0;
        end
        else if ((curr_state == counting || curr_state == waitend) && 
                 counterY == {Y_LENGTH{1'b1}} && counterX == {X_LENGTH{1'b1}}) begin
            slave_counter <= 1;
        end
        else begin
            slave_counter <= slave_counter;
        end
    end
    wire [X_LENGTH - 1 : 0] resultX;
    wire [Y_LENGTH - 1 : 0] resultY;
    assign resultX = (counterX == {X_LENGTH{1'b1}})?{X_LENGTH{1'b1}}:counterX + orgX;
    assign resultY = (counterY == {Y_LENGTH{1'b1}})?{Y_LENGTH{1'b1}}:counterY + orgY;
    assign M_AXIS_TDATA = {resultX, resultY};
    assign M_AXIS_TLAST = 1'b0;
    endmodule