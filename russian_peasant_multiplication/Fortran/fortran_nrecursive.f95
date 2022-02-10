!Name: Rekkab Gill
!ID: 1009210
!email: rekkab@uoguelph.ca
!April 9 2020
!CIS3190 Assignment 4: fortran_nrecursive.f95

program fortran_nrecursive

    implicit none;

    integer(kind = 8) :: mVal, nVal, answer,error
    character(len = 100) :: userInput

    !write out the intro to program
    write(*,1001)
    write(*,*);

    do
        !initialize the user input to a blank
        userInput = ' '
        do
            !prompt the user for multiplier and multiplicand values
            write(*,1002)
            read(*,*,iostat = error) mVal

            write(*, 1003)
            read(*,*,iostat = error) nVal

            if(error == 0) then
                exit
            else
                write(*,*)
                write(*,*)'Error with input, try again'
                write(*,*)   
            end if

        end do

        !perform the calculation
        answer = product(mVal, nVal)

        !display the answer
        write(*,*)
        write(*,1004) answer
        write(*,*)

        !ask if user wants to continue or exit 
        write(*,*)"Enter any key to continue or 'quit' to exit"
        read(*,*)userInput

        if(userInput == 'quit' .or. userInput == 'QUIT') then
            write(*,*)'goodbye.'
            exit
        end if

    end do

    1001 format('Welcome to Russian Peasent Multiplication')
    1002 format('Please enter the first integer: ')
    1003 format('Please enter the second integer: ')
    1004 format('The product of the multiplication is = ',I15.15)

contains

    ! A function to calculate the product for peasent multiplication
    integer(kind = 8) function product(mVal,nVal)

        implicit none

        integer(kind = 8), intent(in) :: mVal, nVal
        integer(kind = 8) :: ans,mplier,mcand

        ! initialize the local variables
        ans = 0
        mplier = mVal
        mcand = nVal

        do

            if(mplier < 1) then 
                exit 
          
            else if(mod(mplier,2) /= 0) then
                ans = ans + mcand
          
            end if
          
            mplier = mplier / 2
            mcand = mcand * 2

        
        end do 

        product = ans

    end function product

end program fortran_nrecursive



