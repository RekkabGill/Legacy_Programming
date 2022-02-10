*> Name: Rekkab Gill (rekkab@uoguelph.ca)
*> ID: 1009210
*> File: exfun.cob
*> CIS3190 Assignment 3 Cobol
*> How to Compile: cobc -m -free -Wall exfun.cob
*> How to use: This is an external function to be used with sqrtbabyex.cob

identification division.
program-id. exfun.
environment division.
data division.
working-storage section.
77 z    picture 9(11)v9(6).
77 k    picture s9999.
77 x    picture 9(11)v9(6).
77 temp picture S9(11)v9(6).
linkage section.
77 inpZ picture s9(10)v9(6) sign leading separate.
77 yVar    picture 9(11)v9(6).

procedure division using inpZ, yVar.

*> calculations for the square root:
s1.
    move inpZ to z.
    divide 2 into z giving x rounded.

    *> Loop statement
    perform s2 varying k from 1 by 1
        until k is greater than 1000.
    
s2. 
    compute yVar rounded = 0.5 * (x + z / x).
    subtract x from yVar giving temp.

    if temp is less than zero then 
        compute temp = - temp
    end-if.

    if temp / (yVar + x) is greater than zero then
        move yVar to x
    end-if.

done.
goback.