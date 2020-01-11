:-  %say
:: we only need entropy num hands and num cards other args not required
|=  [[* eny=@uvJ *] [num-hands=@ud num-cards=@ud ~] ~]
:-  %noun
=<  (deal-hands num-hands num-cards create-unshuffled-deck eny)
|%
::card suits
::
+$  suit  ?(%hearts %spades %clubs %diamonds)
::Card ranks
::
+$  rank  ?(%ace %2 %3 %4 %5 %6 %7 %8 %9 %10 %jack %queen %king)
::A card is a cell of suit and rank
::
+$  crd  [sut=suit rnk=rank]
::A deck is a list of cards
::
+$  deck  (list crd)
::All hands is a list of a list of hands should make a hand type but I am lazy
::
+$  all-hands  (list (list crd))
:: Create a deck with all 52 cards
::
++  create-unshuffled-deck
::Type cast result to a deck
::
  ^-  deck
:: create a new empty deck
::
  =|  newdeck=deck
:: the next lines are for setting up looping variables want to iterate through suits and ranks
::
  =/  suit-iterator  0
  |-
::If we've gone through all the suits create we can return our new deck
::
  ?:  =(suit-iterator 4)
    newdeck
  =/  rank-iterator  2
  |-
  ?:  (gth rank-iterator 14)
:: If we've gone 2-14 for a given suit we want to go to our outer loop so we can begin with a new suit.
::
    ^$(suit-iterator +(suit-iterator))
::Update the deck by adding the new card we've created to the deck and add one to rank iterator.
  %=  $
  newdeck  `deck`[[(num-to-suit suit-iterator) (num-to-rank rank-iterator)] newdeck]
  rank-iterator  +(rank-iterator)
  ==
:: Tranasform nums to suits
::
++  num-to-suit
  |=  num=@ud
  ^-  suit
  ?:  =(num 0)
    %hearts
  ?:  =(num 1)
    %spades
  ?:  =(num 2)
    %clubs
  ?:  =(num 3)
    %diamonds
  !!
++  deal-hands
  |=  [num-hands=@ud num-cards-in-hand=@ud dck=deck entropy=@uvJ]
  ^-  all-hands
  =|  hand-set=all-hands
:: If the user wants us to deal more cards than we have we need to throw an error.
::
  ?:  (gth (mul num-hands num-cards-in-hand) 52)
    !!
  |-
  ?:  =(num-hands 0)
    hand-set
:: We store the hand from deal single hand in our hand set 
::we then get the remaining deck which is in the tail of the the cell returned from deal single hand
:: This is simlar to what we do for getting the random numbers
:: We can then pass the remaing deck to our new instance of deal single hand until we've dealt all hands
:: 
  =^  new-hand  dck  (deal-single-hand num-cards-in-hand dck entropy)
  %=  $
  hand-set  new-hand^hand-set
  num-hands  (dec num-hands)
  ==
:: Returns a list of cards in the head of the cell and the remaining deck with dealt cards removed in the tail
++  deal-single-hand
  |=  [cards-in-hand=@ud curr-deck=deck entropy=@uvJ]
  ^-  [(list crd) deck]
  =|  hand=(list crd)
  =/  random  ~(. og entropy)
  =/  remaining  (lent curr-deck)
  |-
  ?:  (gth cards-in-hand (lent curr-deck))
    !!
  =^  index  random  (rads:random remaining)
  ?:  =(cards-in-hand 1)
    [[(snag index curr-deck) hand] (oust [index 1] curr-deck)]
  %=  $
  cards-in-hand  (dec cards-in-hand)
  remaining  (dec remaining)
  hand  [(snag index curr-deck) hand]
  curr-deck  (oust [index 1] curr-deck)
  ==
:: Transform num to rank they're may be a better way to do this for the numeric constants but idk.
::
++  num-to-rank
  |=  in-val=@ud
  ^-  rank
  ?+  in-val  !!
    %2  %2
    %3  %3
    %4  %4
    %5  %5
    %6  %6
    %7  %7
    %8  %8
    %9  %9
    %10  %10
    %11  %jack
    %12  %queen
    %13  %king
    %14  %ace
  ==
--


