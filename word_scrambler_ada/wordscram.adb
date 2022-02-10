with Ada.Text_IO; use Ada.Text_IO;
with Ada.strings.unbounded; use Ada.strings.unbounded;
with Ada.strings.unbounded.Text_IO; use Ada.strings.unbounded.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Numerics.discrete_random;

procedure wordscram is

--------------------------------- GET FILE NAME PROCEDURE-------------------------------------

    --use this procedure to prompt user for filename or quit the program
    procedure getFilename(textFile : in out file_type) is

        --variables for getFilename
        userInput : unbounded_string;

    begin

        --continuously ask the user for valid filename or quit
        loop
            --ask the user to input the name of a file or enter quit to exit the program
            put_line("Please enter a text file name or 'quit' to exit");
            get_line(userInput);

            --check to see if the user input quit, close any possible open from before files and then quit
            if userInput = "quit" or userInput = "QUIT" then 
                exit;
            end if;

            --attempt to open the file the using the name entered
            begin
                open(textFile,in_file,to_string(userInput));
                exit;
        
            --if opening the file fails for various reasons, raise the exception below
            exception 
                when name_error=>
                new_line;
                put_line("That file name is not valid, try again.");
                new_line;

                when status_error=>
                new_line;
                put_line("That file is already open, try again.");
                new_line;

                when mode_error=>
                new_line;
                put_line("That file name is not valid, try again.");
                new_line;

                when data_error=>
                new_line;
                put_line("That file cannot be read, try again.");
                new_line;

                when use_error=>
                new_line;
                put_line("That file does not have permissions, try again.");
                new_line;
            end;

        end loop;

    end getFilename; 

--------------------------------- CHECK TO SEE IF WORD IS VALID------------------------------

    --checks to see if word length is valid for words greater than 3 and avoids punctuation
    function isWord(wordLength : in integer) return Boolean is
        --variables for isWord
        
    begin

        if wordLength > 3 then
            return true;
        else
            return false;
        end if;

    end isWord;

 
--------------------------------- GET RANDOM INTEGER -------------------------------------

    --random integer generator
    function randomInt(lastIndex : integer) return integer is
        --variables for randomInt

        subtype randRange is natural range 2..lastIndex;
        package Rand_Int is new ada.numerics.discrete_random(randRange);
        use Rand_Int;

        gen : generator;
        num : randRange;

    begin

        reset(gen);
        num := random(gen);
        return num;

    end randomInt;

--------------------------------- SCRAMBLE THE WORD PROCEDURE-------------------------------------

    --scramble the word 
    procedure scrambleWord(someWord : in out string; wordLength : in integer) is
        --variabeles for scrambleWord
        j : integer:= 1;
        lastIndex : constant integer:= wordLength-1;
        randomNumber : integer:= 0;
        originalWord : string(1..100);
        scrambledIndexes : array (1..wordLength) of integer;
        alreadyScrambled : Boolean := false;

    begin 
        --clear the stored indexes  and store the original word
        scrambledIndexes := (1..wordLength => 0);
        originalWord := someWord;

        --loop through the indexes of the word
        for i in 2..lastIndex loop
            
            --continuously loop until a previously unseen random number is generated
            loop 
                --generate a new random number
                randomNumber := randomInt(lastIndex);
                alreadyScrambled := false;

                --check if that random  number has come up before
                for k in 1..scrambledIndexes'length loop

                    if scrambledIndexes(k) = randomNumber then
                        alreadyScrambled := true;
                        exit;
                    end if;
                end loop;

                if alreadyScrambled = false then
                    exit;
                end if;
            end loop;

            --add the random number to the index so it doesnt repeat and change the letter in the word
            scrambledIndexes(j) := randomNumber;
            j := j + 1;
            someWord(randomNumber) := originalWord(i);

        end loop;

    end scrambleWord;

--------------------------------- PROCESS TEXT PROCEDURE------------------------------------

    --process the information retrieved from the text file
    procedure processText(textFile : in file_type) is 

        --varialbes for processText
        fileLine : unbounded_string;
        j : integer:= 1;
        wordLength : integer:= 0;
        indexArray : array (1..100) of integer; 
        wordString : string(1..100);
        wordsScrambled: integer := 0;


    begin

        new_line;
        loop
            exit when end_of_file(textFile);

            --read one line at a time from the text file
            get_line(textFile, fileLine);

            --go through the line, one letter a time and process each word, ignore punctuation
            for i in 1..length(fileLine) loop

                --if a letter is found, store in the word, remember the index, count the word length
                if Is_Letter(element(fileLine,i)) then 
                    wordString(j) := element(fileLine,i);
                    indexArray(j) := i;
                    wordLength := wordLength + 1;
                    j := j +1;

                    --special case if the last character in the line is a letter:
                    if i = length(fileLine) then

                        --add scrambled word to original line that was read from text file
                        if isWord(wordLength) then
                            scrambleWord(wordString,wordLength);
                            wordsScrambled := wordsScrambled + 1;

                            for k in 1..j-1 loop 
                                replace_element(fileLine,indexArray(k),wordString(k));
                            end loop;

                        end if;

                        --reset these variables for use in the next word
                        wordLength := 0;
                        j := 1;
                        wordString := (1..100 => character'val(0));
                        indexArray := (1..100 => 0);
                    end if;

                else
                    -- a non-letter has appeared, check if its a word, if so, scramble it
                    if isWord(wordLength) then
                        scrambleWord(wordString,wordLength);
                        wordsScrambled := wordsScrambled + 1;

                        --replace the scrambled in the original line that was read from the text file
                        for k in 1..j-1 loop 
                            replace_element(fileLine,indexArray(k),wordString(k));
                        end loop;

                    end if;

                    --reset these variables for use in the next word
                    wordLength := 0;
                    j := 1;
                    wordString := (1..100 => character'val(0));
                    indexArray := (1..100 => 0);

                end if;

            end loop;

            --print the line with the scrambled words
            put_line(fileLine);

        end loop;

        --printout how many words were scrambled
        new_line;
        put_line("There were" & integer'image(wordsScrambled) & " words scrambled in the document!");
        new_line;

    end processText;


--------------------------------- BEGINNING OF THE MAIN PROGRAM-------------------------------------
    --variables for wordscram
    textFile : file_type;

begin

    getFilename(textFile);

    if Is_Open(textFile) then 

        processText(textFile);
        close(textFile);
    end if;

end wordscram;