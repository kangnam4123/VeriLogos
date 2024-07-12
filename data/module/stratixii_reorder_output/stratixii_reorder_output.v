module stratixii_reorder_output(
                                  datain,
                                  addnsub,
                                  operation,
                                  dataout
                                 );
parameter  operation_mode = "dynamic";
input [143:0] datain;
input [3:0]      operation;
input  addnsub;
output [143:0] dataout;
reg [143:0]       dataout_tmp;
wire [3:0]    operation;
assign dataout = dataout_tmp;
always @ (datain or addnsub)
    begin
        if(operation_mode == "dynamic")
            begin
                case (operation)
                    4'b1100 : 
                        dataout_tmp = {18'bX, datain[124:108],1'bX, datain[107:72],18'bX, datain[52:36], 1'bX, datain[35:0]};
                    4'b1101 : 
                        dataout_tmp = {datain[143:72], 18'bX, datain[52:36], 1'bX, datain[35:0]};
                    4'b1110 :
                        dataout_tmp = {18'bX, datain[124:108], 1'bX, datain[107:0]};
                    4'b0111 :
                        begin 
                            dataout_tmp[17:0] = (addnsub) ? datain[17:0] : 18'bX;
                            dataout_tmp[35:18] = (addnsub) ? datain[53:36] : 18'bX;
                            dataout_tmp[53:36] = (addnsub) ? datain[35:18] : 18'bX;
                            dataout_tmp[71:54] = (addnsub) ? datain[71:54] : 18'bX;
                            dataout_tmp[143:72] = 72'bX;
                        end
                    default :
                         dataout_tmp = datain;
                endcase
            end
       else
           dataout_tmp = datain;
    end
endmodule