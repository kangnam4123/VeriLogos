module mux4_4_16(
	Sel0, Sel1, Sel2, Sel3,
	Result0, Result1, Result2, Result3,
	Data0x0, Data0x1, Data0x2, Data0x3,
	Data1x0, Data1x1, Data1x2, Data1x3,
	Data2x0, Data2x1, Data2x2, Data2x3,
	Data3x0, Data3x1, Data3x2, Data3x3,
	Data4x0, Data4x1, Data4x2, Data4x3,
	Data5x0, Data5x1, Data5x2, Data5x3,
	Data6x0, Data6x1, Data6x2, Data6x3,
	Data7x0, Data7x1, Data7x2, Data7x3,
	Data8x0, Data8x1, Data8x2, Data8x3,
	Data9x0, Data9x1, Data9x2, Data9x3,
	Data10x0, Data10x1, Data10x2, Data10x3,
	Data11x0, Data11x1, Data11x2, Data11x3,
	Data12x0, Data12x1, Data12x2, Data12x3,
	Data13x0, Data13x1, Data13x2, Data13x3,
	Data14x0, Data14x1, Data14x2, Data14x3,
	Data15x0, Data15x1, Data15x2, Data15x3
);
input Sel0, Sel1, Sel2, Sel3;
output Result0, Result1, Result2, Result3;
input Data0x0, Data0x1, Data0x2, Data0x3;
input Data1x0, Data1x1, Data1x2, Data1x3;
input Data2x0, Data2x1, Data2x2, Data2x3;
input Data3x0, Data3x1, Data3x2, Data3x3;
input Data4x0, Data4x1, Data4x2, Data4x3;
input Data5x0, Data5x1, Data5x2, Data5x3;
input Data6x0, Data6x1, Data6x2, Data6x3;
input Data7x0, Data7x1, Data7x2, Data7x3;
input Data8x0, Data8x1, Data8x2, Data8x3;
input Data9x0, Data9x1, Data9x2, Data9x3;
input Data10x0, Data10x1, Data10x2, Data10x3;
input Data11x0, Data11x1, Data11x2, Data11x3;
input Data12x0, Data12x1, Data12x2, Data12x3;
input Data13x0, Data13x1, Data13x2, Data13x3;
input Data14x0, Data14x1, Data14x2, Data14x3;
input Data15x0, Data15x1, Data15x2, Data15x3;
assign {Result0, Result1, Result2, Result3} =
	{Sel3, Sel2, Sel1, Sel0} == 0 ? { Data0x0, Data0x1, Data0x2, Data0x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 1 ? { Data1x0, Data1x1, Data1x2, Data1x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 2 ? { Data2x0, Data2x1, Data2x2, Data2x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 3 ? { Data3x0, Data3x1, Data3x2, Data3x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 4 ? { Data4x0, Data4x1, Data4x2, Data4x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 5 ? { Data5x0, Data5x1, Data5x2, Data5x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 6 ? { Data6x0, Data6x1, Data6x2, Data6x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 7 ? { Data7x0, Data7x1, Data7x2, Data7x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 8 ? { Data8x0, Data8x1, Data8x2, Data8x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 9 ? { Data9x0, Data9x1, Data9x2, Data9x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 10 ? { Data10x0, Data10x1, Data10x2, Data10x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 11 ? { Data11x0, Data11x1, Data11x2, Data11x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 12 ? { Data12x0, Data12x1, Data12x2, Data12x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 13 ? { Data13x0, Data13x1, Data13x2, Data13x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 14 ? { Data14x0, Data14x1, Data14x2, Data14x3 } :
	{Sel3, Sel2, Sel1, Sel0} == 15 ? { Data15x0, Data15x1, Data15x2, Data15x3 } : 'bx;
endmodule