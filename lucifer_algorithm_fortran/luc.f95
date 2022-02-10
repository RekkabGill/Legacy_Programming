!Name: Rekkab Gill
!ID: 1009210
!email: rekkab@uoguelph.ca
!Jan 31 2020
!CIS3190 Assignment 1: luc.f95

program luc

    implicit none

    integer :: i=0, d=0,key,message,k,m,mb,kb

    dimension k(0:7,0:15),m(0:7,0:7,0:1)
    dimension key(0:127), message(0:127)
    dimension kb(0:31),mb(0:31)

    !get the input for the key value
    write(*,1003)
    read(*,1004) (kb(i),i=0,31)

    !get the input for the message
    write(*,1005)
    read(*,1006) (mb(i),i=0,31)

    !expand the kb and mb, into key and message
    call expand(message,mb,32)
    call expand(key,kb,32)

    ! The reshape function has been used here to ensure the arrays contain the same content,
    ! and to remove the equivalence statement that was present before the change.    
    m = reshape(message,(/8,8,2/))  
    k = reshape(key,(/8,16/))

    ! d = 0 will encipher the message, reshape it back into message, compress it and then print.
    d=0
    call lucifer(d,k,m)
    message = reshape(m,(/128/))
    call compress(message,mb,32)
    write(*,1001)
    write(*,1008)
    write(*,1006) (mb(i),i=0,31)

    ! This is used to decipher the message
    d=1
    call lucifer(d,k,m)
    write(*,1002)

    message = reshape(m,(/128/))
    key = reshape(k,(/128/))

    call compress(message,mb,32)
    call compress(key,kb,32)

    write(*,1003)
    write(*,1006) (kb(i),i=0,31)
    write(*,1005)
    write(*,1006) (mb(i),i=0,31)

    1001  format(' Encrypted message ')
    1002  format(' Decrypted message ')
    1003  format(' key ')
    1004  format(32z1.1)
    1005  format(' plaintext ')
    1006  format(32z1.1)
    1008 format(' ciphertext ')
end

! A subroutine which implements the Lucifer algorithm, allowing for both encryption and decryption.
subroutine lucifer(d,k,m)
    
    implicit none

    integer, intent(in)::d,k
    integer, intent(inout)::m
    integer:: h0=0,h1=0,kc=0,ks=0,ii=0,jj=0,jjj=0,kk=0,v=0,h=0,l=0
    integer:: o,sw,pr,tr,s0,s1
    
    dimension m(0:7,0:7,0:1),k(0:7,0:15),o(0:7)
    dimension sw(0:7,0:7),pr(0:7),tr(0:7)
    dimension s0(0:15),s1(0:15)

    !     diffusion pattern
    o = (/7,6,2,1,5,0,3,4/)

    !     inverse of fixed permutation
    pr = (/2,5,4,0,3,1,7,6/)

    !     S-box permutations
    s0 = (/12,15,7,10,14,13,11,0,2,6,3,1,9,4,5,8/)
    s1 = (/7,2,14,9,3,11,0,4,12,13,1,10,6,15,8,5/)

    h0=0
    h1=1
    kc=0

    if (d .eq. 1) then 
        kc=8
    end if

    do ii=1,16,1

        if (d.eq.1) then 
            kc=mod(kc+1,16)
        end if 

        ks=kc

        do jj=0,7,1
            l=0
            h=0

            do kk=0,3,1
                l=l*2+m(7-kk,jj,h1)
            end do

            do kk=4,7,1
                h=h*2+m(7-kk,jj,h1)
            end do

            v=(s0(l)+16*s1(h))*(1-k(jj,ks))+(s0(h)+16*s1(l))*k(jj,ks)

            do kk=0,7,1
                tr(kk)=mod(v,2)
                v=v/2
            end do

            do kk=0,7,1
                m(kk,mod(o(kk)+jj,8),h0)=mod(k(pr(kk),kc)+tr(pr(kk))+ m(kk,mod(o(kk)+jj,8),h0),2)
            end do

            if (jj .lt. 7 .or. d .eq. 1) then 
                kc=mod(kc+1,16)
            end if 

        end do

        jjj=h0
        h0=h1
        h1=jjj
    end do

    do jj=0,7,1
        do kk=0,7,1
            sw(kk,jj)=m(kk,jj,0)
            m(kk,jj,0)=m(kk,jj,1)
            m(kk,jj,1)=sw(kk,jj)
        end do
    end do

    return 
end

! A subroutine which expands input bytes into binary array format.
subroutine expand(a,b,l)

    implicit none

    integer, intent(out):: a
    integer, intent(in)::b,l
    integer::i=0,v=0,j=0
    dimension a(0:*),b(0:*)

    do i=0,l-1,1
        v=b(i)
        do j=0,3,1
            a((3-j)+i*4)=mod(v,2)
            v=v/2
        end do
    end do

    return
end

! A subroutine which compresses array format back into byte format.
subroutine compress(a,b,l)

    implicit none

    integer, intent(in):: a,l
    integer,intent(out)::b
    integer:: i=0,v=0,j=0
    dimension a(0:*),b(0:*)

    do i=0,l-1,1
        v=0
        do j=0,3,1
            v=v*2+mod(a(j+i*4),2)
        end do
        b(i)=v
    end do

    return
end

