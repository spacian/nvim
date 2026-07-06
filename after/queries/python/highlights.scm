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

(class_definition
  name: (identifier) @class.name
  (#set! priority 101))

(function_definition
  name: (identifier) @function.definition
  (#set! priority 101))

(import_from_statement
  module_name: (dotted_name) @import.path
  name: (dotted_name)  @import.target
  (#set! priority 101))

(import_statement
  name: (dotted_name)  @import.target
  (#set! priority 101))

(class_definition
  body: (block
    (expression_statement
      (assignment
        left: (identifier) @class.expression)))
  (#set! priority 101))

(attribute
  attribute: (identifier) @attribute
  (#set! priority 101))

(decorator
  "@" @decorator
  (call
    function: (identifier) @decorator)
  (#set! priority 101))
