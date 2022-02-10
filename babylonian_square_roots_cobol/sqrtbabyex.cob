*> Name: Rekkab Gill (rekkab@uoguelph.ca)
*> ID: 1009210
*> File: sqrtbabyex.cob
*> CIS3190 Assignment 3 Cobol
*> How to Compile: cobc -x -free -Wall sqrtbabyex.cob
*> How to use: enter any valid non-negative integer and program will
*> output the approximation. The program will ask if you want to continue
*> after each approximation. Enter "no" or "yes" in lowercase only.  

identification division.
program-id. sqrtbabyex.
environment division.
input-output section.
file-control.
     select standard-output assign to display.
data division.
file section.
fd standard-output.
     01 out-line  picture x(80).
working-storage section.
77 y    picture 9(11)v9(6).
77 userAns picture x(50).
77 in-z     picture s9(10)v9(6) sign leading separate.
01 title-line.
    02 filler picture x(9) value spaces.
    02 filler picture x(26) value 'square root approximation'.
01 under-line.
    02 filler picture x(44) value 
        '--------------------------------------------'.
01 col-heads.
    02 filler picture x(8) value spaces.
    02 filler picture x(6) value 'number'.
    02 filler picture x(15) value spaces.
    02 filler picture x(11) value 'square root'.
01 underline-2.
    02 filler picture x(20) value ' -------------------'.
    02 filler picture x(5) value spaces.
    02 filler picture x(19) value '------------------'.
01 print-line.
    02 filler picture x value space.
    02 out-z  picture z(11)9.9(6).
    02 filler picture x(5) value spaces.
    02 out-y  picture z(11)9.9(6).
01 error-mess.
    02 filler picture x value space.
    02 ot-z   picture -(11)9.9(6).
    02 filler picture x(21) value '        invalid input'.
01 user-prompt.
    02 filler picture x(30) value 'Please enter a valid number: '.
01 user-question.
    02 filler picture x(40) value 'Would you like to continue? (yes/no): '.
01 user-tryagain.
    02 filler picture x(20) value 'Please Try Again.'.
procedure division.
    open output standard-output.

s1.
    *> prompt the user for input   
    write out-line from user-prompt after advancing 2 line.
    accept in-z

    write out-line from title-line after advancing 2 lines.
    write out-line from under-line after advancing 1 line.
    write out-line from col-heads after advancing 1 line.
    write out-line from underline-2 after advancing 1 line.

    
    if in-z is greater than zero then

        *> call the external function
        call "exfun" using in-z, y
        perform s2

    else 
        *> error detected, try again
        move in-z to ot-z
        write out-line from error-mess after advancing 1 line
        write out-line from user-tryagain after advancing 2 line
        perform s1 

    end-if.

s2.
       *> print out the results of the calculation 
       move in-z to out-z.
       move y to out-y.
       write out-line from print-line after advancing 1 line.
       perform s3.

s3.
    *> ask the user if they want to continue or exit
    write out-line from user-question after advancing 2 line.
    accept userAns.

    if userAns is EQUAL to "no"
        perform finish
    else
        if userAns is EQUAL to "yes"
           perform s1
        else
           write out-line from user-tryagain after advancing 1 line
           perform s3
        end-if
    end-if.
    
finish.
    close standard-output.
    display 'goodbye.'.
stop run.
