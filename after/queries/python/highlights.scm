; extends

(tuple
  "(" @magic.tuple
  "," @magic.tuple
  ")" @magic.tuple
  (#set! priority 101))

(list
  "[" @magic.list
  (_)
  "]" @magic.list
  (#set! priority 101))

(list
  "[" @magic.list
  "," @magic.list
  "]" @magic.list
  (#set! priority 101))

(dictionary
  "{" @magic.dict
  (pair
    ":" @magic.dict)
  "}" @magic.dict
  (#set! priority 101))

(dictionary
  "{" @magic.dict
  (pair
    ":" @magic.dict)
  "," @magic.dict
  "}" @magic.dict
  (#set! priority 101))
