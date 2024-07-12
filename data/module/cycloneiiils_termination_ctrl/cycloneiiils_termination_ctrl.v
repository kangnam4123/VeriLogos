module cycloneiiils_termination_ctrl (
    clkusr,
    intosc,
    nclrusr,
    nfrzdrv,
    rclkdiv,
    rclrusrinv,
    rdivsel,
    roctusr,
    rsellvrefdn,
    rsellvrefup,
    rtest,
    vccnx,
    vssn,
    clken,
    clkin,
    maskbit,
    nclr,
    noctdoneuser,
    octdone,
    oregclk,
    oregnclr,
    vref,
    vrefh,
    vrefl);
input        clkusr;
input        intosc;       
input        nclrusr;      
input        nfrzdrv;      
input        rclkdiv;      
input        rclrusrinv;   
input        rdivsel;      
input        roctusr;      
input        rsellvrefdn;  
input        rsellvrefup;  
input        rtest;        
input        vccnx;        
input        vssn;         
output       clken;        
output       clkin;
output [8:0] maskbit;
output       nclr;
output       noctdoneuser;
output       octdone;
output       oregclk;
output       oregnclr;
output       vref;
output       vrefh;
output       vrefl;
parameter	REG_TCO_DLY	= 0;  
   reg		divby2;
   reg		divby4;
   reg		divby8;
   reg		divby16;
   reg		divby32;
   reg		oregclk;
   reg	 	oregclkclk;
   reg		intosc_div4;
   reg		intosc_div32;
   reg 		clken;
   reg 		octdoneuser;
   reg 		startbit;
   reg	  [8:0] maskbit;
   reg 		octdone;
   wire	  [8:0] maskbit_d;
   wire		intoscin;
   wire		clk_sel;
   wire		intosc_clk;
   wire		clkin;
   wire		oregnclr;
   wire		clr_invert;
   wire		nclr;
   wire 	adcclk;
   initial 
   begin
       octdone     = 1'b1;    
       octdoneuser = 1'b0;
       startbit    = 1'b0;
       maskbit     = 9'b000000000;
       oregclk     = 1'b0;
       oregclkclk  = 1'b0;
       clken       = 1'b0;
       divby2 = 1'b0;
       divby4 = 1'b0;
       divby8 = 1'b0;
       divby16 = 1'b0;
       divby32 = 1'b0;
       intosc_div4 = 1'b0;
       intosc_div32 = 1'b0;
   end
   assign noctdoneuser	= ~octdoneuser;
    always @(posedge intosc or negedge nfrzdrv) begin
	if (!nfrzdrv) 	divby2 <= #(REG_TCO_DLY) 1'b0;
	else 		divby2 <= #(REG_TCO_DLY) ~divby2;
    end
    always @(posedge divby2 or negedge nfrzdrv) begin
	if (!nfrzdrv) 	divby4 <= #(REG_TCO_DLY) 1'b0;
	else 		divby4 <= #(REG_TCO_DLY) ~divby4;
    end
    always @(posedge divby4 or negedge nfrzdrv) begin
	if (!nfrzdrv) 	divby8 <= #(REG_TCO_DLY) 1'b0;
	else 		divby8 <= #(REG_TCO_DLY) ~divby8;
    end
    always @(posedge divby8 or negedge nfrzdrv) begin
	if (!nfrzdrv) 	divby16 <= #(REG_TCO_DLY) 1'b0;
	else 		divby16 <= #(REG_TCO_DLY) ~divby16;
    end
    always @(posedge divby16 or negedge nfrzdrv) begin
	if (!nfrzdrv) 	divby32 <= #(REG_TCO_DLY) 1'b0;
	else 		divby32 <= #(REG_TCO_DLY) ~divby32;
    end
    assign intoscin	= rdivsel ? divby4 : divby32;    
    assign clk_sel	= octdone & roctusr; 
    assign intosc_clk	= rclkdiv ? intoscin : intosc;
    assign clkin	= clk_sel ? clkusr : intosc_clk;
    assign oregnclr	= rtest | nfrzdrv;   
    assign clr_invert	= rclrusrinv ? ~nclrusr : nclrusr;
    assign nclr		= clk_sel ? clr_invert : nfrzdrv;
    always @(negedge clkin or negedge nclr) begin
	if (!nclr) 	clken <= #(REG_TCO_DLY) 1'b0;
	else	   	clken <= #(REG_TCO_DLY) ~oregclk;
    end 
    always @(negedge clken or negedge oregnclr) begin
	if (!oregnclr)  octdone <= #(REG_TCO_DLY) 1'b0;
	else	    	octdone <= #(REG_TCO_DLY) 1'b1;
    end
    assign adcclk	= clkin & clken;
    always @(posedge adcclk or negedge nclr) begin
	if (!nclr) 
	    startbit	<= #(REG_TCO_DLY) 1'b0;
	else
	    startbit	<= #(REG_TCO_DLY) 1'b1;
    end
    assign maskbit_d	= {~startbit, maskbit[8:1]};
    always @(posedge adcclk or negedge nclr) begin
	if (!nclr) begin
	    maskbit 	<= #(REG_TCO_DLY) 9'b0;
	    oregclkclk	<= #(REG_TCO_DLY) 1'b0;
	end
	else begin
	    maskbit	<= #(REG_TCO_DLY) maskbit_d;
	    oregclkclk	<= #(REG_TCO_DLY) maskbit[0];
	end
    end
    always @(negedge oregclkclk or negedge nclr) begin
	if (~nclr) 	oregclk <= #(REG_TCO_DLY) 1'b0;
	else	   	oregclk <= #(REG_TCO_DLY) 1'b1;
    end
    always @(negedge clken or negedge nclr) begin
	if (~nclr)	octdoneuser <= #(REG_TCO_DLY) 1'b0;
	else		octdoneuser <= #(REG_TCO_DLY) 1'b1;
    end
    assign vrefh = 1'b1;
    assign vref  = 1'b1;
    assign vrefl = 1'b0;
endmodule