module	tlu_prencoder16 (din, dout);
input	[14:0]	din  ;
output	[3:0]	dout ;
wire	[14:0]	onehot ;
assign	onehot[14] = din[14] ;
assign	onehot[13] = din[13] & ~din[14] ;
assign	onehot[12] = din[12] & ~(|din[14:13]) ;
assign	onehot[11] = din[11] & ~(|din[14:12]) ;
assign	onehot[10] = din[10] & ~(|din[14:11]) ;
assign	onehot[9]  = din[9]  & ~(|din[14:10]) ;
assign	onehot[8]  = din[8]  & ~(|din[14:9]) ;
assign	onehot[7]  = din[7]  & ~(|din[14:8]) ;
assign	onehot[6]  = din[6]  & ~(|din[14:7]) ;
assign	onehot[5]  = din[5]  & ~(|din[14:6]) ;
assign	onehot[4]  = din[4]  & ~(|din[14:5]) ;
assign	onehot[3]  = din[3]  & ~(|din[14:4]) ;
assign	onehot[2]  = din[2]  & ~(|din[14:3]) ;
assign	onehot[1]  = din[1]  & ~(|din[14:2]) ;
assign	onehot[0]  = din[0]  & ~(|din[14:1]) ;
assign	dout[3]  =  |onehot[14:7] ;
assign	dout[2]  = (|onehot[6:3]) | (|onehot[14:11]) ;
assign	dout[1]  = (|onehot[2:1]) | (|onehot[6:5]) |
		   (|onehot[10:9]) | (|onehot[14:13]) ;
assign	dout[0]  =  onehot[0] | onehot[2] | onehot[4] | onehot[6] |
		    onehot[8] | onehot[10] | onehot[12] | onehot[14] ;
endmodule