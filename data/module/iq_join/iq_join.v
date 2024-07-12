module iq_join #
(
    parameter WIDTH = 16
)
(
    input  wire              clk,
    input  wire              rst,
    input  wire [WIDTH-1:0]  input_i_tdata,
    input  wire              input_i_tvalid,
    output wire              input_i_tready,
    input  wire [WIDTH-1:0]  input_q_tdata,
    input  wire              input_q_tvalid,
    output wire              input_q_tready,
    output wire [WIDTH-1:0]  output_i_tdata,
    output wire [WIDTH-1:0]  output_q_tdata,
    output wire              output_tvalid,
    input  wire              output_tready
);
reg [WIDTH-1:0] i_data_reg = 0;
reg [WIDTH-1:0] q_data_reg = 0;
reg i_valid_reg = 0;
reg q_valid_reg = 0;
assign input_i_tready = ~i_valid_reg | (output_tready & output_tvalid);
assign input_q_tready = ~q_valid_reg | (output_tready & output_tvalid);
assign output_i_tdata = i_data_reg;
assign output_q_tdata = q_data_reg;
assign output_tvalid = i_valid_reg & q_valid_reg;
always @(posedge clk) begin
    if (rst) begin
        i_data_reg <= 0;
        q_data_reg <= 0;
        i_valid_reg <= 0;
        q_valid_reg <= 0;
    end else begin
        if (input_i_tready & input_i_tvalid) begin
            i_data_reg <= input_i_tdata;
            i_valid_reg <= 1;
        end else if (output_tready & output_tvalid) begin
            i_valid_reg <= 0;
        end
        if (input_q_tready & input_q_tvalid) begin
            q_data_reg <= input_q_tdata;
            q_valid_reg <= 1;
        end else if (output_tready & output_tvalid) begin
            q_valid_reg <= 0;
        end
    end
end
endmodule