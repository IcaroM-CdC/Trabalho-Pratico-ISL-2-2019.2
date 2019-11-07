module Substantivo (clk, Reset, Ready, Tom, Nota, End, Tipo, Nota_A, Tom_A, Saida);


    output reg [6:0] Saida;
	output reg [1:0] Tipo;
    output reg [2:0] Nota_A;
    output reg [2:0] Nota;
    output reg Tom, Ready, clk, Reset, End, Tom_A;
	 


    // O circuito atualizará na borda de subida "Positive edge"
    always@(posedge clk) begin
		  
        // Se o reset tiver o valor 1, o circuito resetará
        // OBS: Para o circuito funcionar de forma correta, é nescessario o resetar antes do uso
        if (Reset == 1'b1) begin
				
            clk <= 1'b1;
            Tom <= 1'b0;
            Nota <= 3'b000;
            Ready <= 1'b0;
            End <= 1'b0;
            Tipo <= 2'b00;
            Tom_A <= 1'b0;
            Nota_A <= 1'b000;
            
        end

        // Caso o reset contenha o valor 0, o algoritmo terá prosseguimento
        
		  else begin

            if (Ready == 1'b1) begin

               
                Saida[6] = ~((~Nota[2] & Nota[0]) | (Nota[1] & ~Nota[0]) | (Tom & Nota[2] & ~Nota[1])); 
	            Saida[5] = ~((~Nota[2] & Nota[1] & ~Nota[0]) | (Nota[2] & Nota[1] & Tom) | (Nota[2] & Nota[1] & Nota[0]) | (Nota[2] & Nota[0] & Nota[1]) | (Nota[2] & ~Nota[1] & ~Nota[0] & ~Tom) | (~Nota[2] & ~Nota[1] & Nota[0] & ~Tom));
    	        Saida[4] = ~((Nota[1] & Nota[0]) | (~Tom & ~Nota[2] & Nota[1]) | (Nota[2] & ~Nota[1] & ~Nota[0]) | (Tom & Nota[2] & ~Nota[1]));
    	        Saida[3] = ~((Nota[1] & Tom) | (Nota[2] & Tom) | (Nota[2] & Nota[1] & ~Nota[0]));
    	        Saida[2] = ~((Nota[0] & ~Tom) | (~Nota[2] & ~Nota[1] & Nota[0]) | (Nota[2] & ~Nota[1] & ~Nota[0])); 
    	        Saida[1] = ~((~Nota[2] & Nota[1] & ~Nota[0]) | (~Tom & Nota[2] & ~Nota[1]) | (Tom & ~Nota[1] & Nota[0]) | (Tom & Nota[2] & Nota[0]));
    	        Saida[0] = ~((Nota[0] & ~Tom) | (Nota[2] & ~Tom) | (Nota[1] & ~Tom));
	 

                // Verifica se é uma letra inválida, caso sim o algoritmo analisa a entrada "anterior"
                if ((Tom == 1'b0 && Nota == 3'b000) || (Tom == 1'b1 && Nota == 3'b000)) begin
                    
                    // Como a entrada é uma letra inválida, como especificado a palavra será encerrada
                    Ready <= 1'b0;
                    End <= 1'b1;
                    
                    // Verifica a entrada "anterior" é uma letra válida, caso sim informa qual substantivo é
                    if ((Tom_A != 1'b0 && Nota_A != 3'b000) || (Tom_A != 1'b1 && Nota_A != 3'b000)) begin
                        
                        if (Tom_A == 1'b0 && Nota_A == 3'b011) begin

                            Tipo <= 2'b11;

                        end
                    
                        if (Tom_A == 1'b0 && Nota_A == 3'b100) begin

                            Tipo <= 2'b10;
   
                        end

                        if (Tom_A == 1'b0 && Nota_A == 3'b101) begin
                        
                            Tipo <= 2'b01;
             
                        end

                        else begin
                            
                            Tipo <= 2'b00;

                        end         
                        
                    end

                    // Se a entrada anterior for inválida, se trata de uma palavra inválida
                    // Porque tanto a entrada atual quanto a anterior são inválidas
                    else begin
                        
                        Tipo <= 2'b00;

                    end 
                                
                end

                // Caso a entrada for uma letra válida o algoritmo vai conferir se é
                // um Dó, Ré, ou um Mi
                else begin

                    if (Tom == 1'b0 && Nota == 3'b011) begin

                        Tom_A <= Tom;
                        Nota_A <= Nota;

                    end
                    
                    if (Tom == 1'b0 && Nota == 3'b100) begin

                        Tom_A <= Tom;
                        Nota_A <= Nota;
   
                    end

                    if (Tom == 1'b0 && Nota == 3'b101) begin
                        
                        Tom_A <= Tom;
                        Nota_A <= Nota;
             
                    end

                    // Se for uma letra válida mas diferente, o algoritmo retornará para o estado inicial
                    else begin
                        
                        Tom_A <= Tom;
                        Nota_A <= Nota;

                    end     


                end

            end
  
  
        end

  
    end


endmodule