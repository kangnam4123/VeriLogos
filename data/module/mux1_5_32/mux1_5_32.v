module mux1_5_32(
	Sel0, Sel1, Sel2, Sel3, Sel4,
	Data0x0, Data1x0, Data2x0, Data3x0, Data4x0, Data5x0, Data6x0, Data7x0, Data8x0, Data9x0, Data10x0, Data11x0, Data12x0, Data13x0, Data14x0, Data15x0,
	Data16x0, Data17x0, Data18x0, Data19x0, Data20x0, Data21x0, Data22x0, Data23x0, Data24x0, Data25x0, Data26x0, Data27x0, Data28x0, Data29x0, Data30x0, Data31x0,
	Result0
);
input Sel0, Sel1, Sel2, Sel3, Sel4;
input Data0x0, Data1x0, Data2x0, Data3x0, Data4x0, Data5x0, Data6x0, Data7x0, Data8x0, Data9x0, Data10x0, Data11x0, Data12x0, Data13x0, Data14x0, Data15x0;
input Data16x0, Data17x0, Data18x0, Data19x0, Data20x0, Data21x0, Data22x0, Data23x0, Data24x0, Data25x0, Data26x0, Data27x0, Data28x0, Data29x0, Data30x0, Data31x0;
output Result0;
assign Result0 =
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 0 ? Data0x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 1 ? Data1x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 2 ? Data2x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 3 ? Data3x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 4 ? Data4x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 5 ? Data5x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 6 ? Data6x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 7 ? Data7x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 8 ? Data8x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 9 ? Data9x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 10 ? Data10x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 11 ? Data11x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 12 ? Data12x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 13 ? Data13x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 14 ? Data14x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 15 ? Data15x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 16 ? Data16x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 17 ? Data17x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 18 ? Data18x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 19 ? Data19x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 20 ? Data20x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 21 ? Data21x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 22 ? Data22x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 23 ? Data23x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 24 ? Data24x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 25 ? Data25x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 26 ? Data26x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 27 ? Data27x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 28 ? Data28x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 29 ? Data29x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 30 ? Data30x0 :
	{Sel4, Sel3, Sel2, Sel1, Sel0} == 31 ? Data31x0 : 'bx;
endmodule