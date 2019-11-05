module substantivo (clk, Reset, Ready, Tom, Nota, End, Tipo, Nota_A, Tom_A;

    input wire [2:0] Nota_in;
    input wire Tom_in;
    output wire [1:0] Tipo;

    reg Tom_A;
    reg [2:0] Nota_A;
    reg [2:0] Nota;
    reg Tom, Ready, clk, Reset, End;


    always@(posedge clk) begin

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

        else begin

            if (Ready == 1'b1) begin

                Tom <= Tom_in;
                Nota <= Nota_in;            


                // Verifica se é uma letra inválida, caso sim o algoritmo analisa a entrada anterior
                if ((Tom == 1'b0 && Nota == 3'b000) || (Tom == 1'b1 && Nota == 3'b000)) begin
                    
                    Ready <= 1'b0;
                    End <= 1'b1;
                    
                    // Verifica a entrada anterior é uma letra válida, caso sim informa qual substantivo é
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