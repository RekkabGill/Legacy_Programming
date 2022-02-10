*> Name: Rekkab Gill (rekkab@uoguelph.ca)
*> ID: 1009210
*> File: cobol_nrecursive.cob
*> CIS3190 Assignment 4 Cobol program
*> How to Compile: cobc -x -free -Wall cobol_nrecursive.cob
*> How to use: enter any valid non-negative integer and program will
*> output the approximation. The program will ask if you want to continue
*> after each approximation. Enter "no" or "yes" in lowercase only.  

identification division.
program-id. a4.
environment division.
input-output section.
file-control.
     select standard-output assign to display.
data division.
file section.
fd standard-output.
     01 out-line  picture x(80).
working-storage section.
77 firstInt  picture 9(20).
77 secondInt picture 9(20).
77 product picture 9(20).
77 remainVal picture 9(20).
77 tempVal picture 9(20).
77 userAns picture x(50).
01 title-line.
    02 filler picture x(9) value spaces.
    02 filler picture x(26) value 'square root approximation'.
01 user-intro.
    02 filler picture x(50) value 'Welcome to Russian peasent multiplication'.
01 user-prompt1.
    02 filler picture x(50) value 'Please enter a valid first integer: '.
01 user-prompt2.
    02 filler picture x(50) value 'Please enter a valid second integer: '.
01 user-question.
    02 filler picture x(40) value 'Would you like to continue? (yes/no): '.
01 user-tryagain.
    02 filler picture x(20) value 'Please Try Again.'.

procedure division.
    open output standard-output.

    *> introduction to program
    write out-line from user-intro after advancing 1 line.

s1.
    *> set values to 0
    compute product = 0.
    compute firstInt = 0.
    compute secondInt = 0.

    *> prompt the user for first input   
    write out-line from user-prompt1 after advancing 2 line.
    accept firstInt.

    *> prompt the user for the second input
    write out-line from user-prompt2 after advancing 1 line. 
    accept secondInt.

    *> perform the loop
    perform s4 until firstInt is less than 1.
    perform s2.

s2.
    *> display the answer once calculation is complete
    display " ".
    display "The product of the multiplication is: " product.
    perform s3.

s3.   
    write out-line from user-question after advancing 1 line.
    accept userAns.

    *> check what the user gave as an answer
    if userAns is equal to "no" then
        perform finish
    else 
        if userAns is equal to "yes"
            perform s1
        else
            write out-line from user-tryagain after advancing 1 line
            perform s3
        end-if
    end-if.

s4.
    divide firstInt by 2 giving tempVal remainder remainVal.
    if remainVal is not equal to zero then
        compute product = product + secondInt
    end-if. 

    compute firstInt = firstInt / 2.
    compute secondInt = secondInt * 2.
    
finish.
    display " ".
    display "goodbye.".
    close standard-output.
stop run.
