:: Hoon 101: Assignment 3a. Comment each line of code to tell the reader what the code is doing.
:: Comments should be written as "breathing comments" as suggested in the Hoon Style Guide: https://urbit.org/docs/learn/hoon/style/
 
::Create a gate accepting unsigned decimal
::
|=  n=@ud
:: assign t specify its an unsigned decimal and set its value to 1
::
=/  t=@ud  1
::this is our recusrion point or looping point (trap)
::
|-
:: if n is 1 we can return t
::
?:  =(n 1)
    t
::On each iteration Set n to n decremented by 1 (n=n-1) and set t to n multiplied by t (ie 5 * 4... as we go through the recursion)
::
$(n (dec n), t (mul t n))