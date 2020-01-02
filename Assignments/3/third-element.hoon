:: Create a gate that accepts a list of nouns
::
|=  lust=(list *)
::pin a var count = 0
::
=/  count  0
::Create a trap (recursion point/loop start)
::
|-
::crash on null we dont have 3 elements!
::
?~  lust  !!
::if i is 2 we return the head of the list
::
?:  =(count 2)  i.lust
:: recurse with count = count + 1 and set lust to be the tail of itself.
::
$(count +(count), lust t.lust)