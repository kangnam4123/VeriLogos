module iq_split #
(
    parameter WIDTH = 16
)
(
    input  wire              clk,
    input  wire              rst,
    input  wire [WIDTH-1:0]  input_i_tdata,
    input  wire [WIDTH-1:0]  input_q_tdata,
    input  wire              input_tvalid,
    output wire              input_tready,
    output wire [WIDTH-1:0]  output_i_tdata,
    output wire              output_i_tvalid,
    input  wire              output_i_tready,
    output wire [WIDTH-1:0]  output_q_tdata,
    output wire              output_q_tvalid,
    input  wire              output_q_tready
);
reg [WIDTH-1:0] i_data_reg = 0;
reg [WIDTH-1:0] q_data_reg = 0;
reg i_valid_reg = 0;
reg q_valid_reg = 0;
assign input_tready = (~i_valid_reg | (output_i_tready & output_i_tvalid)) & (~q_valid_reg | (output_q_tready & output_q_tvalid));
assign output_i_tdata = i_data_reg;
assign output_i_tvalid = i_valid_reg;
assign output_q_tdata = q_data_reg;
assign output_q_tvalid = q_valid_reg;
always @(posedge clk) begin
    if (rst) begin
        i_data_reg <= 0;
        q_data_reg <= 0;
        i_valid_reg <= 0;
        q_valid_reg <= 0;
    end else begin
        if (input_tready & input_tvalid) begin
            i_data_reg <= input_i_tdata;
            q_data_reg <= input_q_tdata;
            i_valid_reg <= 1;
            q_valid_reg <= 1;
        end else begin
            if (output_i_tready) begin
                i_valid_reg <= 0;
            end
            if (output_q_tready) begin
                q_valid_reg <= 0;
            end
        end
    end
end
endmodule