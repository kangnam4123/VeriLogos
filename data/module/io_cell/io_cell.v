module  io_cell (
    pad,                       
    data_in,                   
    data_out_en,               
    data_out                   
);
inout          pad;            
output         data_in;        
input          data_out_en;    
input          data_out;       
assign  data_in  =  pad;
assign  pad      =  data_out_en ? data_out : 1'bz;
endmodule