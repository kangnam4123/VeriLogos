module ALU_10
#( parameter n =16
)(
    input [15:0] operador_1,
    input [15:0] operador_2,
    input [2:0] control,
    output wire [3:0] flags,
    output reg [15:0] resultado
    );
    reg V,C,Z,N;
    assign flags={V,C,Z,N};
    always @(*) begin
        case(control)
            3'd1: resultado= operador_1 + operador_2;
            3'd2: resultado= operador_1 - operador_2;
            3'd3: resultado= operador_1 * operador_2;
            3'd4: resultado= operador_1 & operador_2;
            3'd5: resultado= operador_1 | operador_2;
            default resultado = 16'b0;
        endcase
    end
    always @(*) begin
        case(control)
            3'd1: begin
                        if(operador_1[0]==1'b0 & operador_2[0]==1'b0 & resultado[0]==1'b1) begin
                            V=1'b1;
                        end
                        else begin
                            V=1'b0;
                        end
                        if((operador_1[0]==1'b1 | operador_2[0]==1'b1) & resultado[0]==1'b0) begin
                            C=1'b1;
                        end
                        else begin
                            C=1'b0;
                        end
                  end  
            3'd2: begin
                        if (operador_1[0]==1'b1 & operador_2[0]==1'b1 & resultado[0]==1'b0) begin
                            V=1'b1;
                        end
                        else begin
                            V=1'b0;
                        end
                        if ((operador_1[0]==1'b0 | operador_2[0]==1'b0) & resultado[0]==1'b1) begin
                            C=1'b1;
                        end
                        else begin
                            C=1'b0;
                        end
                  end
            default:{V,C}={1'b0,1'b0};
         endcase
       if (control==3'd2 & operador_1 < operador_2) begin
            N=1'b1;
       end
       else begin
            N=1'b0;
       end
       if (resultado==16'b0) begin
            Z=1'b1;
       end
       else begin
           Z=1'b0;
       end
    end
endmodule