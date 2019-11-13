module Substantivo (Clk, Reset, Pronto, Tom, Nota_A, Nota_B, Nota_C, Estado, Tom_anterior, Nota_anteriorA, Nota_anteriorB, Nota_anteriorC, Display1, Display2, Display3, Tom_input, A_input, B_input, C_input);

    input wire Pronto, Tom_input, A_input, B_input, C_input;
    input wire Clk, Reset; 

    output reg Tom, Nota_A, Nota_B, Nota_C;
    output reg Tom_anterior, Nota_anteriorA, Nota_anteriorB, Nota_anteriorC;
    output reg [2:0] Estado;

    output reg [6:0] Display1; //Mostra no display 7 SGM qual a saida do circuito
    output reg [6:0] Display2; //Mostra no display 7 SGM qual a saida do circuito
    output reg [6:0] Display3; //Mostra no display 7 SGM qual a letra atual

    parameter Concreto = 2'b11;
    parameter Abstrato = 2'b10;
    parameter Nome_proprio = 2'b01;
    parameter Invalido = 2'b00; 

    always @(posedge Clk) begin
        
        if (Reset) begin
            
            Tom <= 1'b0;
            Nota_A <= 1'b0;
            Nota_B <= 1'b0;
            Nota_C <= 1'b0;
            
            Tom_anterior <= 1'b0;
            Nota_anteriorA <= 1'b0;
            Nota_anteriorB <= 1'b0;
            Nota_anteriorC <= 1'b0;

        end

        else begin

            if (Pronto) begin 

                Tom <= Tom_input;
                Nota_A <= A_input;
                Nota_B <= B_input;
                Nota_C <= C_input;

                Display3[6] = ~((Nota_C & ~Tom) || (Nota_A & ~Tom) || (Nota_B & ~Tom));
                Display3[5] = ~((~Nota_A && Nota_B && ~Nota_C) || (~Tom && Nota_A && ~Nota_B) | (Tom && ~Nota_B && Nota_C) || (Tom && Nota_A && Nota_C));
                Display3[4] = ~((Nota_C && ~Tom) || (~Nota_A && ~Nota_B && Nota_C) || (Nota_A && ~Nota_B && ~Nota_C));
                Display3[3] = ~((Nota_B && Tom) || (Nota_A && Tom) || (Nota_A && Nota_B && ~Nota_C));
                Display3[2] = ~((Nota_B && Nota_C) || (~Tom && ~Nota_A && Nota_B) || (Nota_A && ~Nota_B && ~Nota_C) || (Tom && Nota_A && ~Nota_B));
                Display3[1] = ~((~Nota_A && Nota_B && ~Nota_C) || (Nota_A && Nota_B && Tom) || (Nota_A && Nota_B && Nota_C) || (Nota_A && Nota_C && Nota_B) || (Nota_A && ~Nota_B && ~Nota_C && ~Tom) || (~Nota_A && ~Nota_B && Nota_C && ~Tom));
                Display3[0] = ~((~Nota_A && Nota_C) || (Nota_B && ~Nota_C) || (Tom && Nota_A && ~Nota_B)); 

                if (Nota_A == 1'b0 && Nota_B == 1'b0 && Nota_C == 1'b0) begin
                    
                    Estado <= Invalido;

                    if (Tom_anterior == 1'b0 && Nota_anteriorA == 1'b0 && Nota_anteriorB == 1'b1 && Nota_anteriorC == 1'b1) begin
                        
                        Estado <= Concreto;

                    end

                    if (Tom_anterior == 1'b0 && Nota_anteriorA == 1'b1 && Nota_anteriorB == 1'b0 && Nota_anteriorC == 1'b0) begin
                        
                        Estado <= Abstrato;

                    end

                    if (Tom_anterior == 1'b0 && Nota_anteriorA == 1'b1 && Nota_anteriorB == 1'b0 && Nota_anteriorC == 1'b1) begin
                        
                        Estado <= Nome_proprio;

                    end

                    else begin
                        
                        Estado <= Invalido;

                    end 
                    
                end 

                if (Tom == 1'b0 && Nota_A == 1'b0 && Nota_B == 1'b1 && Nota_C == 1'b1) begin
                    
                    Estado <= Concreto;

                    Nota_anteriorA <= Nota_A;
                    Nota_anteriorB <= Nota_B;
                    Nota_anteriorC <= Nota_C;

                end

                if (Tom == 1'b0 && Nota_A == 1'b1 && Nota_B == 1'b0 && Nota_C == 1'b0) begin

                    Estado <= Abstrato;

                    Nota_anteriorA <= Nota_A;
                    Nota_anteriorB <= Nota_B;
                    Nota_anteriorC <= Nota_C;

                end
                
                if (Tom == 1'b0 && Nota_A == 1'b1 && Nota_B == 1'b0 && Nota_C == 1'b1) begin

                    Estado <= Nome_proprio;

                    Nota_anteriorA <= Nota_A;
                    Nota_anteriorB <= Nota_B;
                    Nota_anteriorC <= Nota_C;


                end

                else begin
                    
                    Estado <= Invalido;

                    Nota_anteriorA <= Nota_A;
                    Nota_anteriorB <= Nota_B;
                    Nota_anteriorC <= Nota_C;

                end

            end 

            
        end

    end

    always @(Estado) begin

        if (Estado == Concreto) begin
            
            Display1[6] <= 1'b1;
            Display1[5] <= 1'b1;  
            Display1[4] <= 1'b1;  
            Display1[3] <= 1'b1;  
            Display1[2] <= 1'b0;  
            Display1[1] <= 1'b0;  
            Display1[0] <= 1'b1;  

            Display2[6] <= 1'b1;
            Display2[5] <= 1'b1;  
            Display2[4] <= 1'b1;  
            Display2[3] <= 1'b1;  
            Display2[2] <= 1'b0;  
            Display2[1] <= 1'b0;  
            Display2[0] <= 1'b1;

        end 
        
        if (Estado == Abstrato) begin
            
            Display1[6] <= 1'b1;
            Display1[5] <= 1'b1;  
            Display1[4] <= 1'b1;  
            Display1[3] <= 1'b1;  
            Display1[2] <= 1'b0;  
            Display1[1] <= 1'b0;  
            Display1[0] <= 1'b1;  

            Display2[6] <= 1'b1;
            Display2[5] <= 1'b1;  
            Display2[4] <= 1'b1;  
            Display2[3] <= 1'b1;  
            Display2[2] <= 1'b1;  
            Display2[1] <= 1'b1;  
            Display2[0] <= 1'b0;

        end 

        if (Estado == Nome_proprio) begin
            
            Display1[6] <= 1'b1;
            Display1[5] <= 1'b1;  
            Display1[4] <= 1'b1;  
            Display1[3] <= 1'b1;  
            Display1[2] <= 1'b1;  
            Display1[1] <= 1'b1;  
            Display1[0] <= 1'b0;

            Display2[6] <= 1'b1;
            Display2[5] <= 1'b1;  
            Display2[4] <= 1'b1;  
            Display2[3] <= 1'b1;  
            Display2[2] <= 1'b0;  
            Display2[1] <= 1'b0;  
            Display2[0] <= 1'b1;  

        end

        if (Estado == Invalido) begin
            
            Display1[6] <= 1'b1;
            Display1[5] <= 1'b1;  
            Display1[4] <= 1'b1;  
            Display1[3] <= 1'b1;  
            Display1[2] <= 1'b1;  
            Display1[1] <= 1'b1;  
            Display1[0] <= 1'b0;

            Display2[6] <= 1'b1;
            Display2[5] <= 1'b1;  
            Display2[4] <= 1'b1;  
            Display2[3] <= 1'b1;  
            Display2[2] <= 1'b1;  
            Display2[1] <= 1'b1;  
            Display2[0] <= 1'b0;

        end
    end

endmodule //Substantivo