!Name: Rekkab Gill
!ID: 1009210
!email: rekkab@uoguelph.ca
!Jan 31 2020
!CIS3190 Assignment 1: hex.f95

!A function which takes input from the user in the form of  a word to be encrypted, 
!and returns the word to the calling program. 
subroutine readWord(w)
    
    implicit none 
    
    character(len =*), intent(out):: w

    write(*,1000)
    1000 format(' Enter word: ')
    read(*,*)w

    return
end

! A function which converts the ASCII word obtained using readWord() to hexadecimal
subroutine word2hex(w,h,l)

    implicit none 

    character(len=*),intent(in):: w
    character(len=2):: tempChar
    integer,intent(out):: h(1:*)
    integer,intent(out):: l
    integer :: i=1, j = 0, wordLength = 0;

    !trim the word string of any trailing blanks then get true length of string
    wordLength = len_trim(w)

    do 
        if(i > wordLength) then 
            exit
        end if
        
        !read the string into temporary characters, then put into hex array
        write(tempChar,'(z2)') w(i:i)
        read(tempChar(1:1),'(z1)') h(j+1)
        read(tempChar(2:2),'(z1)') h(j+2)
        i = i + 1
        j = j + 2
    end do

    !set the length of the hex array
    l = j
end

!A function which prints the word in hexadecimal. 
subroutine printhex(h,l)

    implicit none

    integer,intent(in):: l
    integer,intent(in):: h(1:*)
    integer:: i = 1

    !print out the hex Array
    write(*,1001)
    write(*,1002) (h(i),i=1,l)

    1001  format(' Hexadecimal word: ')
    1002  format(32z1.1)

    return
end 
 