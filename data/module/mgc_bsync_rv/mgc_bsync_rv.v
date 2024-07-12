module mgc_bsync_rv (rd, vd, rz, vz);
    parameter integer rscid   = 0; 
    parameter ready = 1;
    parameter valid = 1;
    input  rd;
    output vd;
    output rz;
    input  vz;
    wire   vd;
    wire   rz;
    assign rz = rd;
    assign vd = vz;
endmodule