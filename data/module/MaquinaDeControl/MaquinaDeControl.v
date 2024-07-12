module MaquinaDeControl(
		input Clock,
		input Reset,
		input NewScanCode,
		input NewAscii,
		output reg LoadDato,
		output reg LoadChar,
		output reg ScanCodeType
);
 reg [1:0]state;
 parameter Sleep  = 3'h0;
 parameter Recibido  = 3'h1;
 parameter Type = 3'h3;
 parameter New = 3'h2;
always @(negedge Clock) begin
	if (Reset)
		state = Sleep;
	else begin
		case(state)
		Sleep:begin
			if(NewScanCode) state=Recibido;
			else state=Sleep;
		end
		Recibido:begin
			if(!Reset) state=Type;
		end
		Type:begin
			if(!NewAscii || Reset) state=Sleep;
			else if(NewAscii || !Reset) state=New;
		end
		New: state=Sleep;
		default: state = Sleep ;
		endcase
	end
end
always @(state) begin
  case(state)
    Sleep :begin
		LoadDato=0;
		LoadChar=0;
		ScanCodeType=0;
		end
    Recibido :begin
		LoadDato=1;
		LoadChar=0;
		ScanCodeType=0;
		end
    Type:begin
		LoadDato=0;
		LoadChar=0;
		ScanCodeType=1;
		end
    New:begin
		LoadDato=0;
		LoadChar=1;
		ScanCodeType=0;
		end
    default:begin
		LoadDato=0;
		LoadChar=0;
		ScanCodeType=0;
       end
  endcase
end
endmodule