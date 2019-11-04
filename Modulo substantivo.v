module substantivo (clk, Reset, Ready, Tom, Nota, End, Tipo;

    input wire [2:0] Nota_in;
    input wire Tom_in;

    reg [2:0] Nota;
    reg [1:0] Tipo
    reg Tom, Ready, clk, Reset, End;


    always@(posedge clk) begin

        if (Reset == 1'b1) begin

            clk <= 1'b1;
            Tom <= 1'b0;
            Nota <= 3'b000;
            Ready <= 1'b0;
            End <= 1'b0;
            Tipo <= 2'b00;
            
        end

        else begin

            if (Ready == 1'b1) begin

                Tom <= Tom_in;
                Nota <= Nota_in;            



                if ((Tom == 1'b0 && Nota == 3'b000) || (Tom == 1'b1 && Nota == 3'b000)) begin
                    
                    Ready <= 1'b0;
                    End <= 1'b1;
                    Tipo <= 2'b00;
                                
                end

                else begin
                    
                    if ((Tom == 1'b0 && Nota == 3'b000) || (Tom == 1'b1 && Nota == 3'b000)) begin
                        
                        Tipo <= 2'b00;
                        Ready <= 1'b0;
                        End < = 1'b1;

                    end

                    if (Tom == 1'b0 && Nota == 3'b011) begin

                        Tipo <= 2'b11;

                    end
                    
                    if (Tom == 1'b0 && Nota == 3'b100) begin

                        Tipo <= 2'b10;
   
                    end

                    if (Tom == 1'b0 && Nota == 3'b101) begin
                        
                        Tipo <= 2'b01;
             
                    end


                end


            end
  
  
        end

  
    end


endmodule