; extends

(tuple
  "(" @magic.tuple
  "," @magic.tuple
  ")" @magic.tuple
  (#set! priority 150))

(list
  "[" @magic.list
  (_)
  "]" @magic.list
  (#set! priority 150))

(list
  "[" @magic.list
  "," @magic.list
  "]" @magic.list
  (#set! priority 150))

(dictionary
  "{" @magic.dict
  (pair
    ":" @magic.dict)
  "}" @magic.dict
  (#set! priority 150))

(dictionary
  "{" @magic.dict
  (pair
    ":" @magic.dict)
  "," @magic.dict
  "}" @magic.dict
  (#set! priority 150))

(class_definition
  name: (identifier) @class.name
  (#set! priority 150))

(function_definition
  name: (identifier) @function.definition
  (#set! priority 150))

(import_from_statement
  module_name: (dotted_name) @import.path
  name: (dotted_name)  @import.target
  (#set! priority 150))

(import_statement
  name: (dotted_name)  @import.target
  (#set! priority 150))

(class_definition
  body: (block
    (expression_statement
      (assignment
        left: (identifier) @class.expression)))
  (#set! priority 150))

(attribute
  attribute: (identifier) @attribute
  (#set! priority 150))

(decorator
  "@" @decorator
  [
    (identifier) @decorator
    (attribute) @decorator
    (call function: (identifier) @decorator)
    (call function: (attribute) @decorator)
  ]
  (#set! priority 175))

(type
  [
    (identifier) @type
    (attribute) @type
  ]
  (#set! priority 175))

((integer) @number
  (#set! priority 200))

((float) @number
  (#set! priority 200))

((string) @string
  (#set! priority 200))
