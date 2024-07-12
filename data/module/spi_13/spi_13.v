module spi_13 (
   input wire clk,         
   input wire enviar_dato, 
   input wire recibir_dato,
   input wire [7:0] din,   
   output reg [7:0] dout,  
   output reg oe_n,        
   output reg wait_n,
   output wire spi_clk,    
   output wire spi_di,     
   input wire spi_do       
   );
   reg ciclo_lectura = 1'b0;       
   reg ciclo_escritura = 1'b0;     
   reg [4:0] contador = 5'b00000;  
   reg [7:0] data_to_spi;          
   reg [7:0] data_from_spi;        
   reg [7:0] data_to_cpu;          
   assign spi_clk = contador[0];   
   assign spi_di = data_to_spi[7]; 
   initial wait_n = 1'b1;
   always @(posedge clk) begin
      if (enviar_dato && !ciclo_escritura) begin  
         ciclo_escritura <= 1'b1;
         ciclo_lectura <= 1'b0;
         contador <= 5'b00000;
         data_to_spi <= din;
         wait_n <= 1'b0;         
      end
      else if (recibir_dato && !ciclo_lectura) begin 
         ciclo_lectura <= 1'b1;
         ciclo_escritura <= 1'b0;
         contador <= 5'b00000;
         data_to_cpu <= data_from_spi;
         data_from_spi <= 8'h00;
         data_to_spi <= 8'hFF;  
         wait_n <= 1'b0;         
      end
      else if (ciclo_escritura==1'b1) begin
         if (contador!=5'b10000) begin
            if (contador == 5'b01000)
                wait_n <= 1'b1;            
            if (spi_clk==1'b1) begin
               data_to_spi <= {data_to_spi[6:0],1'b0};
               data_from_spi <= {data_from_spi[6:0],spi_do};
            end
            contador <= contador + 1;
         end
         else begin
            if (!enviar_dato)
               ciclo_escritura <= 1'b0;
         end
      end
      else if (ciclo_lectura==1'b1) begin
         if (contador!=5'b10000) begin
            if (contador == 5'b01000)
                wait_n <= 1'b1;            
            if (spi_clk==1'b1)
               data_from_spi <= {data_from_spi[6:0],spi_do};
            contador <= contador + 1;
         end
         else begin
            if (!recibir_dato)
               ciclo_lectura <= 1'b0;
         end
      end
   end
   always @* begin
      if (recibir_dato) begin
         dout = data_to_cpu;
         oe_n = 1'b0;
      end
      else begin
         dout = 8'hZZ;
         oe_n = 1'b1;
      end
   end   
endmodule