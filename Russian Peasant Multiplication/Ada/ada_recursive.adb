with Ada.Text_IO; use Ada.Text_IO;
with Ada.strings.unbounded; use Ada.strings.unbounded;
with Ada.strings.unbounded.Text_IO; use Ada.strings.unbounded.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Integer_text_io; use Ada.Integer_text_io;
with Ada.Long_Integer_Text_IO; use Ada.Long_Integer_Text_IO;

procedure ada_recursive is

--------------------------------- RECURSIVE FUNCTION-------------------------------------
    function product( multiplier : Long_Integer; multiplicand : Long_Integer) return Long_Integer is

    begin 
        
        if multiplier = 1 then 
            return multiplicand;
        
        elsif multiplier >  1 and multiplier mod 2 = 0 then 
            return product( multiplier / 2, multiplicand * 2);

        elsif multiplier > 1 and multiplier mod 2 = 1 then
            return multiplicand + product(multiplier / 2, multiplicand * 2);
        
        else
            return 0;

        end if;

    end product;

--------------------------------- BEGINNING OF THE MAIN PROGRAM-------------------------------------

-- Main Program variables
pVal, mVal, nVal : Long_Integer;
userInput : unbounded_string;

begin 

    new_line;
    put_line("Welcome to Russian Peasent Multiplication.");
    new_line;

    --allow for continuous use of the program
    loop

        begin
        --get the two inputs necessary for the calculation
        put("Please enter a valid first integer: ");
        get(mVal);

        put("Please enter a valid second integer: ");
        get(nVal);

        --do the calculation
        pVal := product(mVal,nVal);

        --display the results
        new_line;
        put_line("The product is: " & long_integer'image(pVal)); 
        new_line;
    
        --if there is an invalid input in the multiplier or multiplicand
        exception
            when data_error=>
            new_line;
            put_line("input is not valid, you may try again.");
            new_line;

        end;


        --prompt the user to see if they want to continue with another multiplication
        put_line("Enter any key to continue or quit to exit");
        Skip_Line;
        get_line(userInput);

        --check if the user input quit and exit program if they did
        if userInput = "quit" or userInput = "QUIT" then 
            put_line("goodbye.");
            exit;
        end if;

        new_line;

    end loop;

end ada_recursive;

