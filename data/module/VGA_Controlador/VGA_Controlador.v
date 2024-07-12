module VGA_Controlador(
input wire _clk_,
input wire _reset_,
output reg hsync,
output reg vsync,
output reg [10:0] PixelX,
output reg [10:0] PixelY,
output reg video_encendido
    );
parameter TotalHorizontalPixels = 11'd800;
parameter HorizontalSyncWidth = 11'd96;
parameter VerticalSyncWidth = 11'd2;
parameter TotalVerticalLines = 11'd525;
parameter HorizontalBackPorchTime = 11'd144 ;
parameter HorizontalFrontPorchTime = 11'd784 ;
parameter VerticalBackPorchTime = 11'd12 ;
parameter VerticalFrontPorchTime = 11'd492;
reg VerticalSyncEnable;
reg [10:0] HorizontalCounter;
reg [10:0] VerticalCounter;
always @(posedge _clk_ or posedge _reset_)
begin
	if(_reset_ == 1)
		HorizontalCounter <= 0;
	else
		begin
			if(HorizontalCounter == TotalHorizontalPixels - 1)
				begin 
					HorizontalCounter<=0;
					VerticalSyncEnable <= 1;
				end
			else
				begin 
					HorizontalCounter<=HorizontalCounter+1; 
					VerticalSyncEnable <=0;
				end
		end
end
always @(*)
begin
	if((HorizontalCounter<HorizontalSyncWidth))
		hsync = 1;
	else
		hsync = 0;
end
always @(posedge _clk_ or posedge _reset_)
begin
	if(_reset_ == 1)
		VerticalCounter<=0;
	else
	begin
		if(VerticalSyncEnable == 1)
			begin
				if(VerticalCounter==TotalVerticalLines-1)
					VerticalCounter<=0;
				else
					VerticalCounter<=VerticalCounter+1;
			end
	end
end
always @(*)
begin
	if(VerticalCounter < VerticalSyncWidth)
		vsync = 1;
	else
		vsync = 0;
end
always @(posedge _clk_)
begin
	if((HorizontalCounter<HorizontalFrontPorchTime) && (HorizontalCounter>HorizontalBackPorchTime) && (VerticalCounter<VerticalFrontPorchTime) && (VerticalCounter>VerticalBackPorchTime))
		begin
			video_encendido <= 1;
			PixelX<= HorizontalCounter - HorizontalBackPorchTime;
			PixelY<= VerticalCounter - VerticalBackPorchTime;
		end
	else
		begin
			video_encendido <= 0;
			PixelX<=0;
			PixelY<=0;
		end
end
endmodule