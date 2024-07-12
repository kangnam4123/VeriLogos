module mgc_bsync_rdy (rd, rz);
    parameter integer rscid   = 0; 
    parameter ready = 1;
    parameter valid = 0;
    input  rd;
    output rz;
    wire   rz;
    assign rz = rd;
endmodule