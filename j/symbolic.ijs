NB. symbolic functions, expanded from an idea here:
NB. http://www.jsoftware.com/docs/help701/dictionary/samp19.htm
NB.
NB. you can use these to test whot arbitrary combinators do.
cocurrent'symbolic'


isbox =: 32 = 3!:0
isint =:  4 = 3!:0
isbit =:  1 = 3!:0

typ =: (4!:0)
ob =: ^:_1




NB. name newv -> create symbolic verb that uses parens
newv =: 1 : 0  
  '(', (": m), ' ', (": y), ')' 
:
  '(', (": x) ,' ', (": m) ,' ', (": y), ')'
)

NB. name boxv -> create symbolic verb that renders as boxes 
boxv =: 1 : ('(": m) ; (": y)';':';'(": x) ; (": m) ; (": y)')

NB. obverses (custom inverses)
updn =: ([: |. 'abcdefghijklmnopqrstuvwxyz'&i. { 7 u: 'ɐqɔpǝɟƃɥᴉɾʞ?ɯuodbɹsʇnʌʍxʎz'"_)
ov =: 1 : ' (m newv) :. ((updn m) newv)'

NB. create symbolic noun:
nsym  =: 13 : 0
   ". y , '=: ''' , y , ''''
)

NB. creaty symbolic verb:
vsym =: 13 : 0
  ". , y , '=: ''' , y , ''' ov'
)

NB. operate on words in a string (delimited by spaces):
wds =: 3 : '];._1 '' '',y'
fwd =: 1 : 0
  r =. a: for_wd. a: -.~ wds y do. r=. r , <u wd-.' ' end. }. r
)

NB. declare some symbols for us to play with:
syms =: 3 : 0
  nsym fwd 'z m n'
  vsym fwd 'a b c d e f g h'
)
syms''

NB. we have to declare these manually because they're in use:
". args =:'(x=:''x'');(y=:''y'');(u=:''u''ov);(v=:''v''ov)'


NB. verbs for pasting into irc bot
src =: 13 : '5!:5 < y -. (0{a.)'
lns =: 13 : '<;._1 LF,y'
toirc =: 3 : 0
  echo ') ', y
:
   ys =. lns y
   ys =. ys -. a:
  if. (# ys) = 1 do.
    echo ') ' , x , '=:', (,>ys)
  else. 
    echo   ').. ', x , ' =: ',  >{. ys
    for_ln. }.}:ys do.
      echo ').. ', >ln
    end.
    echo   ') )'
  end.
)

NB. generate the irc version
'updn' toirc '([: |. ''abcdefghijklmnopqrstuvwxyz''&i. { 7 u: ''ɐqɔpǝɟƃɥᴉɾʞ?ɯuodbɹsʇnʌʍxʎz''"_)'
(toirc src) fwd 'ob typ parv boxv newv ov nsym vsym wds fwd syms toirc'
toirc args

NB. the idea here is that invoking the function creates a string:
assert         (f 0)        =   '(f 0)'
assert         (f y)        =   '(f y)'
assert       (x f y)        =   '(x f y)'

NB. now we will create two strings for each law, and test to
NB. make sure the strings equal each other.

NB. trains
NB. ---------------------------------------------------
assert         ((f g) y)    =   (y f (g y))             NB. monadic hook
assert       (x (f g) y)    =   (x f (g y))             NB. dyadic hook

assert       (  (f g h) y)  =   ((  f y) g (  h y))     NB. monadic fork
assert       (x (f g h) y)  =   ((x f y) g (x h y))     NB. dyadic fork

assert      (([: g h) y)    =   (g (  h y))             NB. monadic capped fork
assert    (x ([: g h) y)    =   (g (x h y))             NB. dyadic capped fork

assert        ((e f g h) y) =  ((e (f g h)) y)          NB. hook rule repeats when total length is even
assert        ((e f g h) y) = (y e ((f y) g (h y )))    NB. fully expanded

assert      ((d e f g h) y) = ((d e (f g h)) y)         NB. fork rule repeats when total length is odd
assert      ((d e f g h) y) = ((d y) e ((f y) g (h y))) NB. fully expanded


NB. noun-verb conjunctions
NB. ---------------------------------------------------
assert       ((f & y) x)    =  (x f y)
assert       ((x & f) y)    =  (x f y)

NB. verb-verb conjunctions
NB. ---------------------------------------------------
assert        ((f &  g) y)   =  (f (g y))
assert        ((f &: g) y)   =  (f (g y))
assert        ((f @  g) y)   =  (f (g y))
assert        ((f @: g) y)   =  (f (g y))

assert        (x (f &  g) y)   =  ((g x) f (g y))
assert        (x (f &: g) y)   =  ((g x) f (g y))
assert        (x (f @  g) y)   =  (f (x g y))
assert        (x (f @: g) y)   =  (f (x g y))


NB. adverbs
NB. ---------------------------------------------------
assert       (f ~ y )       =  (y f y)

assert       (f  ~ i.3)     =  '(0 1 2 f 0 1 2)'
assert       (f  / i.3)     =  '(0 f (1 f 2))'
assert       (f ~/ i.3)     =  '((2 f 1) f 0)'

NB. gerunds
NB. ---------------------------------------------------
assert   x (f`g`h @. 0) y   =  (x f y)
assert   x (f`g`h @. 1) y   =  (x g y)
assert   x (f`g`h @. 2) y   =  (x h y)

