module vga_seg(
    input [3:0] num,
    input [10:0] hc,
    input [10:0] vc,
    input [10:0] hs,
    input [10:0] vs,
    output yes);
wire a = (hc>=hs+2 && hc<=hs+13 && vc>=vs && vc<=vs+2);
wire b = (hc>=hs+13 && hc<=hs+15 && vc>=vs+2 && vc<=vs+14);
wire c = (hc>=hs+13 && hc<=hs+15 && vc>=vs+16 && vc<=vs+28);
wire d = (hc>=hs+2 && hc<=hs+13 && vc>=vs+28 && vc<=vs+30);
wire e = (hc>=hs && hc<=hs+2 && vc>=vs+16 && vc<=vs+28);
wire f = (hc>=hs && hc<=hs+2 && vc>=vs+2 && vc<=vs+14);
wire g = (hc>=hs+2 && hc<=hs+13 && vc>=vs+14 && vc<=vs+16);
assign yes = (num == 0) ? a|b|c|d|e|f : 
             (num == 1) ? b|c :
             (num == 2) ? a|b|d|e|g :
             (num == 3) ? a|b|c|d|g :
             (num == 4) ? b|c|f|g :
             (num == 5) ? a|c|d|f|g : 
             (num == 6) ? a|c|d|e|f|g :
             (num == 7) ? a|b|c :
             (num == 8) ? a|b|c|d|e|f|g :
             (num == 9) ? a|b|c|d|f|g : 0;
endmodule