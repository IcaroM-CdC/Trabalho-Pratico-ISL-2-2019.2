module Substantivo (clk, Reset, Ready, Tom, Nota_A, Nota_B, Nota_C, End, Tipo, Anterior_A, Anterior_B, Anterior_C, Tom_anterior, Saida, Nota_A_in, Nota_B_in, Nota_C_in, Tom_in);


    output reg [6:0] Saida;
	output reg [1:0] Tipo;
    output reg Anterior_A, Anterior_B, Anterior_C;
    output reg Nota_A, Nota_B, Nota_C, Nota_A_in, Nota_B_in, Nota_C_in, Tom_in;
    output reg Tom, Ready, clk, Reset, End, Tom_anterior;



    // O circuito atualizará na borda de subida "Positive edge"
    always@(posedge clk) begin
		  
        // Se o reset tiver o valor 1, o circuito resetará
        // OBS: Para o circuito funcionar de forma correta, é nescessario o resetar antes do uso
        if (Reset == 1'b1) begin
				
            Tom <= 1'b0;
            Nota_A <= 1'b0;
            Nota_B <= 1'b0;
            Nota_C <= 1'b0;
            Ready <= 1'b0;
            End <= 1'b1;
            Tipo <= 2'b00;
            
            Tom_anterior <= 1'b0;
            Anterior_A <= 1'b0;
            Anterior_B <= 1'b0;
            Anterior_C <= 1'b0;

            Saida[6] <= 1'b0;
            Saida[5] <= 1'b0;
            Saida[4] <= 1'b0;
            Saida[3] <= 1'b1;
            Saida[2] <= 1'b1;
            Saida[1] <= 1'b0;
            Saida[0] <= 1'b1;
            
        end

        // Caso o reset contenha o valor 0, o algoritmo terá prosseguimento
        
		else begin

            if (Ready == 1'b1) begin

                Tom <= Tom_in;
                Nota_A <= Nota_A_in;
                Nota_B <= Nota_B_in;
                Nota_C <= Nota_C_in;

                // Verifica se é uma letra inválida, caso sim o algoritmo analisa a entrada "anterior"
                if ((Tom == 1'b0 && Nota_A == 1'b0 && Nota_B == 1'b0 && Nota_C == 1'b0) || (Tom == 1'b1 && Nota_A == 1'b0 && Nota_B == 1'b0 && Nota_C == 1'b0)) begin
                    
                    // Como a entrada é uma letra inválida, como especificado a palavra será encerrada
                    
					Ready <= 1'b0;
                    End <= 1'b1;
                    
                    // Verifica a entrada "anterior" é uma letra válida, caso sim informa qual substantivo é
                    if ((Tom_anterior != 1'b0 && Anterior_A != 1'b0 && Anterior_B != 1'b0 && Anterior_C != 1'b0) || (Tom_anterior != 1'b1 && Anterior_A != 1'b0 && Anterior_B != 1'b0 && Anterior_C != 1'b0)) begin
                        
                        if (Tom_anterior == 1'b0 && Anterior_A != 1'b0 && Anterior_B != 1'b1 && Anterior_C != 1'b1) begin

                            Tipo <= 2'b11;

                        end
                    
                        else if (Tom_anterior == 1'b0 && Anterior_A != 1'b1 && Anterior_B != 1'b0 && Anterior_C != 1'b0) begin

                            Tipo <= 2'b10;
   
                        end

                        else if (Tom_anterior == 1'b0 && Anterior_A != 1'b1 && Anterior_B != 1'b0 && Anterior_C != 1'b1) begin
                        
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

                    // Mostra no display de 7 segmentos qual é a letra válida inserida no FPGA

                    Saida[6] = ~((~Nota_A && Nota_C) || (Nota_B && ~Nota_C) || (Tom && Nota_A && ~Nota_B)); 
	                Saida[5] = ~((~Nota_A && Nota_B && ~Nota_C) || (Nota_A && Nota_B && Tom) || (Nota_A && Nota_B && Nota_C) || (Nota_A && Nota_C && Nota_B) || (Nota_A && ~Nota_B && ~Nota_C && ~Tom) || (~Nota_A && ~Nota_B && Nota_C && ~Tom));
    	            Saida[4] = ~((Nota_B && Nota_C) || (~Tom && ~Nota_A && Nota_B) || (Nota_A && ~Nota_B && ~Nota_C) || (Tom && Nota_A && ~Nota_B));
    	            Saida[3] = ~((Nota_B && Tom) || (Nota_A && Tom) || (Nota_A && Nota_B && ~Nota_C));
    	            Saida[2] = ~((Nota_C && ~Tom) || (~Nota_A && ~Nota_B && Nota_C) || (Nota_A && ~Nota_B && ~Nota_C)); 
    	            Saida[1] = ~((~Nota_A && Nota_B && ~Nota_C) || (~Tom && Nota_A && ~Nota_B) || (Tom && ~Nota_B && Nota_C) || (Tom && Nota_A && Nota_C));
    	            Saida[0] = ~((Nota_C && ~Tom) || (Nota_A && ~Tom) || (Nota_B && ~Tom));
	 
                    if (Tom == 1'b0 && Nota_A == 1'b0 && Nota_B == 1'b1 && Nota_C == 1'b1) begin

                        Tom_anterior <= Tom;
                        Anterior_A <= Nota_A;
                        Anterior_B <= Nota_B;
                        Anterior_C <= Nota_C;
                        
                        Tipo <= 2'b11;

                    end
                    
                    if (Tom == 1'b0 && Nota_A == 1'b1 && Nota_B == 1'b0 && Nota_C == 1'b0) begin

                        Tom_anterior <= Tom;
                        Anterior_A <= Nota_A;
                        Anterior_B <= Nota_B;
                        Anterior_C <= Nota_C;
                        
                        Tipo <= 2'b10;

                    end

                    if (Tom == 1'b0 && Nota_A == 1'b1 && Nota_B == 1'b0 && Nota_C == 1'b1) begin
                        
                        Tom_anterior <= Tom;
                        Anterior_A <= Nota_A;
                        Anterior_B <= Nota_B;
                        Anterior_C <= Nota_C;

                        Tipo <= 2'b01;
             
                    end

                    // Se for uma letra válida mas diferente, o algoritmo retornará para o estado inicial
                    else begin
                        
                        Tom_anterior <= Tom;
                        Anterior_A <= Nota_A;
                        Anterior_B <= Nota_B;
                        Anterior_C <= Nota_C;

                        Tipo <= 2'b00;

                    end     


                end

            end
  
  
        end

  
    end


endmodule