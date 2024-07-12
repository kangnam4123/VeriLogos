module mul4(
				input	[3 : 0]			iSOURCE0,
				input	[3 : 0]			iSOURCE1,
				output	[7 : 0]			oOUTPUT);
	assign	oOUTPUT	=	((iSOURCE0[0])? iSOURCE1 : 7'h00) + ((iSOURCE0[1])? iSOURCE1 << 1 : 7'h00) + ((iSOURCE0[2])? iSOURCE1 << 2 : 7'h00) + ((iSOURCE0[3])? iSOURCE1 << 3 : 7'h00);
endmodule