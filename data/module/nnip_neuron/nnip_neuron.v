module nnip_neuron
    #(
    parameter WIDTH = 8
    )(
    input  wire                 aclk,
    input  wire                 arstn,
    input  wire                 ce,
    input  signed [  WIDTH-1:0] x0,
    input  signed [  WIDTH-1:0] x1,
    input  signed [  WIDTH-1:0] x2,
    input  signed [  WIDTH-1:0] x3,
    input  signed [  WIDTH-1:0] c0,
    input  signed [  WIDTH-1:0] c1,
    input  signed [  WIDTH-1:0] c2,
    input  signed [  WIDTH-1:0] c3,
    output signed [2*WIDTH-1:0] y
    );
    reg [2*WIDTH-1:0] mac;
    always @ (posedge aclk or negedge arstn) begin
        if (arstn == 1'b0) begin
            mac <= {2 * WIDTH{1'b0}};
        end
        else begin
            if (ce == 1'b1)
                mac <= x0 * c0 + x1 * c1 + x2 * c2 + x3 * c3;
        end
    end
    assign y = mac;
endmodule